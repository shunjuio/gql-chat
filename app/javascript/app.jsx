import React from 'react';

const mockDatas = [
  {id: 1, name: "one", date: "1/1", content: "ああああああああああああ"},
  {id: 2, name: "two", date: "1/2", content: "ああああああああああああ"},
  {id: 3, name: "three", date: "1/3", content: "ああああああああああああ"},
]

const App = function () {
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
      {mockDatas.map((mockData) => (
        <section className="flex flex-col items-center border-1 py-4 my-10">
          <div className="flex justify-around w-full">
            <p>{mockData.name}</p>
            <p>{mockData.date}</p>
          </div>
          <p className="p-2">{mockData.content}</p>
        </section>
      ))}
      </div>
    </div>
  )
}

export { App }
