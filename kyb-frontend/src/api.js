import axios from 'axios';

// Base API URL
const API_URL = `${process.env.REACT_APP_API_URL}/api/v1`;

// Function to log in a user
export const login = (credentials) => {
  return axios.post(`${API_URL}/sessions`, credentials);
};

// Function to log out a user
export const logout = () => {
  return axios.delete(`${API_URL}/sessions`);
};

// Add more API functions as needed
