import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Header from './Header';
import Home from './components/Index';
import Login from './components/Login';
import CompanyList from './components/CompanyList';
import CompanyDetails from './components/CompanyDetail';
import ParentComponent from './components/ParentComponent'; // Import ParentComponent
import { login, logout } from './api'; // Import login and logout functions from api.js

const App = () => {
  // State to track user authentication status
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  // Function to handle user login
  const handleLogin = async (credentials) => {
    try {
      await login(credentials);
      setIsAuthenticated(true);
    } catch (error) {
      console.error('Login failed:', error);
    }
  };

  // Function to handle user logout
  const handleLogout = async () => {
    try {
      await logout();
      setIsAuthenticated(false);
    } catch (error) {
      console.error('Logout failed:', error);
    }
  }
  
  return (
    <Router>
      <div>
        <Header userSignedIn={isAuthenticated} handleLogout={handleLogout} />
        <div className="container mt-4">
          <Switch>
            <Route exact path="/" component={Home} />
            <Route path="/login">
              <Login onLogin={handleLogin} />
            </Route>
            <Route path="/company-list">
              {/* Render CompanyList component if user is authenticated, otherwise redirect to login */}
              <CompanyList />
            </Route>

            <Route path="/company-details/:id">
              {/* Render CompanyDetails component if user is authenticated, otherwise redirect to login */}
              <CompanyDetails />
            </Route>

            <Route path="/parent-component">
              {/* Render ParentComponent component */}
              <Route path="/parent-component" component={ParentComponent} />
            </Route>

            {/* Add more routes for other pages */}
          </Switch>
        </div>
      </div>
    </Router>
  );
};

export default App;
