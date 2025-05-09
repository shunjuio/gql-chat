import { ApolloClient, ApolloLink, InMemoryCache, split, HttpLink, Observable } from '@apollo/client';
import { getMainDefinition } from '@apollo/client/utilities';
import consumer from './channels/index';
import { print } from 'graphql/language/printer';

// ActionCable WebSocketリンクを作成するクラス
class ActionCableLink extends ApolloLink {
  constructor(options) {
    super(); // ApolloLink を継承する場合は super() を呼ぶ
    this.consumer = options.consumer;
  }

  request(operation) {
    return new Observable(observer => {
      const channel = this.consumer.subscriptions.create(
        { channel: 'GraphqlChannel' }, // サーバー側のチャンネル名と一致させる
        {
          connected: () => {
            try {
              const queryAsString = print(operation.query); // print関数を使ってクエリ文字列を取得
              channel.perform('execute', {
                query: queryAsString,
                variables: operation.variables,
                operationName: operation.operationName,
              });
            } catch (error) {
              console.error("ActionCableLink: Error performing execute:", error);
              observer.error(error);
            }
          },
          received: (data) => {
            if (data.result) {
              if (data.result.data) {
                observer.next(data.result);
              }
              if (data.result.errors) {
                console.error("ActionCableLink: GraphQL errors received:", data.result.errors);
                observer.error(new Error(data.result.errors.map(e => e.message).join('\n')));
              }
            } else if (data.errors) {
              console.error("ActionCableLink: Top-level errors received:", data.errors);
              observer.error(new Error(data.errors.map(e => e.message).join('\n')));
            } else if (data.type === "reject_subscription") {
              console.error("ActionCableLink: Subscription rejected by server");
              observer.error(new Error("Subscription rejected"));
            }
          },
          disconnected: () => {
            console.log("ActionCableLink: WebSocket disconnected");
            observer.error(new Error("WebSocket disconnected")); // 再接続のためにエラーを投げる
          }
        }
      );

      // unsubscribe時の処理
      return () => {
        console.log("ActionCableLink: Unsubscribing and disconnecting channel");
        channel.unsubscribe();
      };
    });
  }
}

// HTTP通信用のリンク
const httpLink = new HttpLink({
  uri: '/graphql',
  headers: {
    "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.content || null,
  }
});

// WebSocket用のリンク
const cableLink = new ActionCableLink({
  consumer
});

// リンクを分割する
const link = split(
  ({ query }) => {
    const definition = getMainDefinition(query);
    return (
      definition.kind === 'OperationDefinition' &&
      definition.operation === 'subscription'
    );
  },
  cableLink,
  httpLink
);

export const createClient = (options) => {
  return new ApolloClient({
    link,
    cache: new InMemoryCache(),
    ...options,
  });
};
