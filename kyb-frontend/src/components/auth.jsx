import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Switch, useHistory } from 'react-router-dom';
import Header from '../Header';
import Home from '../components/Index';
import Login from '../components/Login';
import CompanyList from '../components/CompanyList';
import CompanyDetails from '../components/CompanyDetail';
import { login, logout } from '../api'; // Import login and logout functions from api.js

const Auth = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const history = useHistory();
  useEffect(() => {
    // Check if the authentication token exists in localStorage
    const token = localStorage.getItem('token');
    if (token) {
      setIsAuthenticated(true);
    }
  }, []); // Run only once on component mount

  const handleLogin = async (credentials) => {
    try {
      setIsAuthenticated(true);
      await login(credentials);
    } catch (error) {
      console.error('Login failed:', error);
    }
  };

  const handleLogout = async () => {
    try {
      await logout();
      setIsAuthenticated(false);
      localStorage.removeItem('token');
      window.location.href = "/"
    } catch (error) {
      console.error('Logout failed:', error);
    }
  }

console.log("render")
  return (
    <Router>
      <div>
        <Header userSignedIn={isAuthenticated} handleLogout={handleLogout} />
        <div className="container mt-4">
          <Switch>
            <Route exact path="/" component={Home} />
            <Route path="/company-list">
              <CompanyList />
            </Route>
            <Route path="/company-details/:id">
              <CompanyDetails />
            </Route>
            <Route path="/login">
              <Login onLogin={handleLogin} />
            </Route>
          </Switch>
        </div>
      </div>
    </Router>
  )

}
export default Auth