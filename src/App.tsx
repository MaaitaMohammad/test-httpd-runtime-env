import { BrowserRouter, Route, Routes } from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<div>root</div>} />
        <Route
          path="test"
          element={<div>{window.masterConfig.apiBaseUrl}</div>}
        />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
