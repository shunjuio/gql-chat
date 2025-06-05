import React from 'react';
import { createRoot } from 'react-dom/client';
import { App } from './app';
import { ApolloProvider } from '@apollo/client';
import { createClient } from './client';

const client = createClient()

const root = document.getElementById('root');
if (root) {
  createRoot(root).render(
    <React.StrictMode>
      <ApolloProvider client={client}>
        <App />
      </ApolloProvider>
    </React.StrictMode>
  );
}
