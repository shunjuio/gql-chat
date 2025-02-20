import { useMutation, useQuery } from "@apollo/client";
import { graphql } from "./gql";
import React, { useState } from "react";

const GET_MESSAGES = graphql(`
  query GetMessages($first: Int!, $after: String!) {
    messages(first: $first, after: $after) {
      edges {
        node {
          id
          senderName
          content
          createdAt
        }
      }
    }
  }
`);

const CREATE_MESSAGE = graphql(`
  mutation CreateMessage($content: String!) {
    createMessage(input: { content: $content }) {
      message {
        id
        senderName
        content
        createdAt
      }
    }
  }
`);

const Form = function ({ createMessage }) {
  const [content, setContent] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    createMessage({
      variables: { content },
    }).then(() => {
      setContent("");
    });
  };

  return (
    <div className="pt-2">
      <form
        className="flex flex-col border-1 px-4 py-2"
        onSubmit={handleSubmit}
      >
        <textarea
          value={content}
          placeholder="content"
          className="mx-10 border border-gray-300 rounded-md p-2 my-2"
          onChange={(e) => setContent(e.target.value)}
        />
        <button
          className="mx-auto max-w-20 bg-blue-500 text-white rounded-md p-2 hover:bg-blue-600"
          type="submit"
        >
          投稿する
        </button>
      </form>
    </div>
  );
};

const List = function ({ messages }) {
  return (
    <div>
      {messages.map((message) => (
        <div
          className="flex flex-col items-center border-1 py-4 my-10"
          key={message.id}
        >
          <div className="flex justify-around w-full">
            <p>{message.senderName}</p>
            <p>{message.createdAt}</p>
          </div>
          <p className="p-2">{message.content}</p>
        </div>
      ))}
    </div>
  );
};

const App = function () {
  const { data, loading, error } = useQuery(GET_MESSAGES, {
    variables: {
      first: 10,
      after: "",
    },
  });
  const messages = data ? data.messages.edges.map((edge) => edge.node) : [];
  const [createMessage] = useMutation(CREATE_MESSAGE, {
    update(cache, { data }) {
      const message = data.createMessage.message;
      cache.modify({
        fields: {
          messages(existingMessages = []) {
            const newExistingMessages = structuredClone(existingMessages);
            const newMessageRef = cache.writeFragment({
              data: message,
              fragment: graphql(`
                fragment NewMessage on Message {
                  id
                  senderName
                  content
                  createdAt
                }
              `),
            });
            const edge = {
              __typename: "MessageEdge",
              node: newMessageRef,
            };
            newExistingMessages.edges = [edge, ...newExistingMessages.edges];
            return newExistingMessages;
          },
        },
      });
    },
  });

  return (
    <div className="mx-auto max-w-[640px] px-10">
      <Form createMessage={createMessage} />
      <List messages={messages} />
    </div>
  );
};

export { App };
