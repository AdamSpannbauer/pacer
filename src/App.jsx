import React from 'react';
import './App.css';

function App() {
  const handleFasterClick = () => {
    // eslint-disable-next-line no-console
    console.log('faster');
  };

  const handleSlowerClick = () => {
    // eslint-disable-next-line no-console
    console.log('slower');
  };

  return (
    <div className="App">
      <div className="buttons-container">
        <button className="button" type="button" id="faster-btn" onClick={handleFasterClick}>
          Faster <span role="img" aria-label="rabbit">🐇</span>
        </button>
        <button className="button" type="button" id="slower-btn" onClick={handleSlowerClick}>
          Slower <span role="img" aria-label="rabbit">🐢</span>
        </button>
      </div>
    </div>
  );
}

export default App;
