// Header.jsx

import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

const Header = ({ userSignedIn, handleLogout }) => { 

  const token = localStorage.getItem('token');

  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-light">
      <div className="container">
        <Link className="navbar-brand" to="/">KYBModule</Link>
        <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span className="navbar-toggler-icon"></span>
        </button>
        <div className="collapse navbar-collapse" id="navbarNav">
          <ul className="navbar-nav ml-auto">
            <li className="nav-item">
              {userSignedIn ? (
                <Link to="/company-list" className="nav-link">Home</Link>
              ) : (
                <Link to="/" className="nav-link">Home</Link>
              )}
            </li>
            <li className="nav-item">
              {token ? (
                <button className="nav-link btn btn-link" onClick={handleLogout}>Logout</button>
              ) : (
                <Link to="/login" className="nav-link">Login</Link>
              )}
            </li>
          </ul>
        </div>
      </div>
    </nav>
  );
};

export default Header;
