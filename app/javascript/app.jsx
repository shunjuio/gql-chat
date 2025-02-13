import React from 'react';

const mockDatas = [
  {id: 1, name: "one", date: "1/1", content: "aaa"},
  {id: 2, name: "two", date: "1/2", content: "bbb"},
  {id: 3, name: "three", date: "1/3", content: "ccc"},
]

const App = function () {
  return (
    <div>
      <div>
      {mockDatas.map((mockData) => (
        <section className="flex flex-col items-center border-1 py-4 my-10">
          <div className="flex justify-around w-full">
            <p>{mockData.name}</p>
            <p>{mockData.date}</p>
          </div>
          <p className="">{mockData.content}</p>
        </section>
      ))}
      </div>
    </div>
  )
}

export { App }
