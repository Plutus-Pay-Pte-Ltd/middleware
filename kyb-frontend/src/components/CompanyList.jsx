import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';

const CompanyList = () => {
  const [companies, setCompanies] = useState([]);

  useEffect(() => {
    axios.get(`${process.env.REACT_APP_API_URL}/api/v1/companies`, {
      headers: {
        Authorization: `${localStorage.getItem('token')}`
      }
    })
    .then(response => {
      setCompanies(response.data);
    })
    .catch(error => {
      console.error('There was an error fetching the companies!', error);
    });
  }, []);

  return (
    <div className="container">
      <h1 className="text-center mt-5 mb-4">Company Index Page</h1>
      <div className="row row-cols-1 row-cols-md-2 g-4">
        {companies.map(company => (
          <div key={company.id} className="col mb-4">
            <div className="card shadow">
              <div className="card-body">
                <h5 className="card-title mb-4">{company.legal_name}</h5>
                <p className="card-text"><strong>Address:</strong> {company.address}</p>
                <p className="card-text"><strong>Email:</strong> {company.email}</p>
                <p className="card-text"><strong>Primary Phone:</strong> {company.primary_phone}</p>
                <p className="card-text"><strong>Primary Contact Name:</strong> {company.primary_contact_name}</p>
                <p className="card-text"><strong>Status:</strong> {company.review_status}</p>
                <div className="d-grid gap-2 d-md-flex justify-content-md-end">
                  <Link to={`/company-details/${company.id}`} className="btn btn-primary btn-sm me-md-2">View</Link>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CompanyList;
