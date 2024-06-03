// CompanyDetails.jsx

import React, { useState, useEffect }  from 'react';
import { Link } from 'react-router-dom';

const CompanyDetails = ({  currentUser}) => {

  const [company, setCompany ] =  useState({});;

  useEffect(() => {
    const fetchCompanyDetails = async () => {
      try {
        debugger
        const response = await axios.get(`${process.env.REACT_APP_API_URL}/api/v1/companies/${match.params.id}`);
        setCompany(response.data);
        setLoading(false);
      } catch (error) {
        setError(error);
        setLoading(false);
      }
    };
    fetchCompanyDetails();
    return () => {
      // Cancel ongoing requests here if needed
    };
  }, []);

  const handleApprove = async () => {
    try {
      const response = await axios.patch(`/api/v1/companies/${company.id}/approve`);
      // Handle success
    } catch (error) {
      console.error('Error approving company:', error);
      // Handle error
    }
  };

  // Function to handle rejection of a company
  const handleReject = async () => {
    try {
      const response = await axios.patch(`/api/v1/companies/${company.id}/reject`);
      // Handle success
    } catch (error) {
      console.error('Error rejecting company:', error);
      // Handle error
    }
  };

  return (
    <div className="container">
      <div className="row justify-content-center">
        <div className="col-md-8">
          <div className="card mt-4">
            <div className="card-header">
              <h5 className="card-title">Company Details</h5>
            </div>
            <div className="card-body">
              <ul className="list-group list-group-flush">
                <li className="list-group-item"><strong>Legal Name:</strong> {company.legal_name}</li>
                <li className="list-group-item"><strong>Director Name:</strong> {company.director_name}</li>
                <li className="list-group-item"><strong>Director Designation:</strong> {company.director_designation}</li>
                <li className="list-group-item"><strong>Director Contact:</strong> {company.director_contact}</li>
                <li className="list-group-item"><strong>Address:</strong> {company.address}</li>
                <li className="list-group-item"><strong>Email:</strong> {company.email}</li>
                <li className="list-group-item"><strong>Primary Phone:</strong> {company.primary_phone}</li>
                <li className="list-group-item"><strong>Primary Contact Name:</strong> {company.primary_contact_name}</li>
                <li className="list-group-item"><strong>Primary Contact Phone:</strong> {company.primary_contact_phone}</li>
              </ul>
            </div>
          </div>

          <div className="card mt-4">
            <div className="card-header">
              <h5 className="card-title">Documents</h5>
            </div>
            <div className="card-body">
              <ul className="list-group list-group-flush">
                <li className="list-group-item">
                  <strong>Certificate of Incorporation:</strong>
                  {company.certificate_of_incorporation ? (
                    <a href={company.certificate_of_incorporation}>View Document</a>
                  ) : (
                    'No document attached'
                  )}
                </li>
                <li className="list-group-item">
                  <strong>GST Certificate:</strong>
                  {company.gst_certificate ? (
                    <a href={company.gst_certificate}>View Document</a>
                  ) : (
                    'No document attached'
                  )}
                </li>
                <li className="list-group-item">
                  <strong>PAN Document:</strong>
                  {company.pan_document ? (
                    <a href={company.pan_document}>View Document</a>
                  ) : (
                    'No document attached'
                  )}
                </li>
              </ul>
            </div>
          </div>

          <div className="mt-4">
            <Link to="/companies" className="btn btn-secondary">Back</Link>
            { company.pending_review && (
              <div className="btn-group" role="group" aria-label="Accept or Reject">
                <button onClick={handleApprove} className="btn btn-success me-2">Accept</button>
                <button onClick={handleReject} className="btn btn-danger" data-toggle="modal" data-target="#rejectionModal">Reject</button>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default CompanyDetails;
