import { ApolloClient, InMemoryCache, ApolloLink, HttpLink } from '@apollo/client';
import { createPersistedQueryLink } from '@apollo/client/link/persisted-queries';
import { generatePersistedQueryIdsFromManifest } from '@apollo/persisted-query-lists';
import ActionCableLink from 'graphql-ruby-client/subscriptions/ActionCableLink';
import { createConsumer } from '@rails/actioncable'

// HTTP通信用のリンク
const httpLink = new HttpLink({
  uri: '/graphql',
  headers: {
    "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.content || null,
  }
});

// Persisted Query用のリンク
const persistedQueryLink = createPersistedQueryLink(
  generatePersistedQueryIdsFromManifest({
    loadManifest: () => import('./persisted-query-manifest.json'),
  })
);

// WebSocket用のリンク
const cableLink = new ActionCableLink({
  cable: createConsumer('/cable')
});

const hasSubscriptionOperation = ({ query: { definitions } }) => {
  return definitions.some(
    ({ kind, operation }) => kind === 'OperationDefinition' && operation === 'subscription'
  )
}

const link = ApolloLink.split(
  hasSubscriptionOperation,
  cableLink,
  ApolloLink.concat(persistedQueryLink, httpLink)
);

export const createClient = (options) => {
  return new ApolloClient({
    link,
    cache: new InMemoryCache(),
    ...options,
  });
};
