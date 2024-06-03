// ParentComponent.jsx

import React, { useState } from 'react';
import CompanyDetails from './CompanyDetail';
import axios from 'axios';

const ParentComponent = () => {
  const [company, setCompany] = useState(null); // Assuming you fetch company data and set it here
  const [currentUser, setCurrentUser] = useState(null); // Assuming you have currentUser state

  // Function to handle approval of a company
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
    <div>
      {company && currentUser && (
        <CompanyDetails
          company={company}
          currentUser={currentUser}
          handleApprove={handleApprove}
          handleReject={handleReject}
        />
      )}
    </div>
  );
};

export default ParentComponent;
