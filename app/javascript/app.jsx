import { useQuery } from '@apollo/client';
import { graphql } from './gql';
import React from 'react'

const GET_MESSAGES = graphql(`
  query GetMessages {
    messages {
      id
      senderName
      content
      createdAt
    }
  }
`);

const App = function () {
  const { data, loading, error } = useQuery(GET_MESSAGES);

  return (
    <div className="mx-auto max-w-[640px] px-10">
      <div className="pt-2">
        <form className="flex flex-col border-1 px-4 py-2">
          <input
            type="text"
            placeholder="name"
            className="max-w-32 border border-gray-300 rounded-md p-2"
          />
          <textarea
            placeholder="content"
            className="mx-10 border border-gray-300 rounded-md p-2 my-2"
          />
          <button className="mx-auto max-w-20 bg-blue-500 text-white rounded-md p-2 hover:bg-blue-600">
            submit
          </button>
        </form>
      </div>

      <div>
        {data?.messages.map((message) => (
          <section className="flex flex-col items-center border-1 py-4 my-10" key={message.id}>
            <div className="flex justify-around w-full">
              <p>{message.senderName}</p>
              <p>{message.createdAt}</p>
            </div>
            <p className="p-2">{message.content}</p>
          </section>
        ))}
      </div>
    </div>
  )
}

export { App }
