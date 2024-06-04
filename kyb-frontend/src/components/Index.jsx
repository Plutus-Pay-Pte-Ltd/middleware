import React, { useState } from 'react';
import axios from 'axios';

const CompanyForm = () => {
  const [company, setCompany] = useState({
    legal_name: '',
    director_name: '',
    director_designation: '',
    director_contact: '',
    address: '',
    email: '',
    primary_phone: '',
    primary_contact_name: '',
    primary_contact_phone: '',
    certificate_of_incorporation: null,
    gst_certificate: null,
    pan_document: null
  });
  const [errors, setErrors] = useState([]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setCompany(prevCompany => ({
      ...prevCompany,
      [name]: value
    }));
  };

  const handleFileChange = (e) => {
    const { name, files } = e.target;
    setCompany(prevCompany => ({
      ...prevCompany,
      [name]: files[0]
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    const data = { company: company}  
  

    try {
      const response = await axios.post(`${process.env.REACT_APP_API_URL}/api/v1/companies`, data, {
        headers: {
          'Content-Type': 'multipart/form-data',
          Authorization: localStorage.getItem('token')
        }
      });
      console.log('Company created:', response.data);
      window.location.href = '/';
    } catch (error) {
      if (error.response && error.response.data && error.response.data.errors) {
        setErrors(error.response.data.errors);
      } else {
        console.error('There was an error creating the company:', error);
      }
    }
  };

  return (
    <div className="container mt-5">
      <div className="row justify-content-center">
        <div className="col-md-8">
          <div className="card">
            <div className="card-body">
              <h1 className="card-title text-center mb-4">Create Company</h1>
              {errors.length > 0 && (
                <div className="alert alert-danger" role="alert">
                  <h4 className="alert-heading">Errors prohibited this company from being saved:</h4>
                  <ul>
                    {errors.map((error, index) => (
                      <li key={index}>{error}</li>
                    ))}
                  </ul>
                </div>
              )}
              <form onSubmit={handleSubmit} encType="multipart/form-data">
                <div className="row">
                  <div className="mb-3">
                    <label htmlFor="legal_name" className="form-label">Legal Name</label>
                    <input
                      type="text"
                      id="legal_name"
                      name="legal_name"
                      className="form-control"
                      value={company.legal_name}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="mb-3">
                    <label htmlFor="director_name" className="form-label">Director Name</label>
                    <input
                      type="text"
                      id="director_name"
                      name="director_name"
                      className="form-control"
                      value={company.director_name}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="mb-3">
                    <label htmlFor="director_designation" className="form-label">Director Designation</label>
                    <input
                      type="text"
                      id="director_designation"
                      name="director_designation"
                      className="form-control"
                      value={company.director_designation}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="mb-3">
                    <label htmlFor="director_contact" className="form-label">Director Contact</label>
                    <input
                      type="text"
                      id="director_contact"
                      name="director_contact"
                      className="form-control"
                      value={company.director_contact}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="mb-3">
                    <label htmlFor="address" className="form-label">Address</label>
                    <input
                      type="text"
                      id="address"
                      name="address"
                      className="form-control"
                      value={company.address}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col-md-6">
                    <label htmlFor="email" className="form-label">Email</label>
                    <input
                      type="text"
                      id="email"
                      name="email"
                      className="form-control"
                      value={company.email}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="mb-3">
                    <label htmlFor="primary_phone" className="form-label">Primary Phone</label>
                    <input
                      type="text"
                      id="primary_phone"
                      name="primary_phone"
                      className="form-control"
                      value={company.primary_phone}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="mb-3">
                    <label htmlFor="primary_contact_name" className="form-label">Primary Contact Name</label>
                    <input
                      type="text"
                      id="primary_contact_name"
                      name="primary_contact_name"
                      className="form-control"
                      value={company.primary_contact_name}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="mb-3">
                    <label htmlFor="primary_contact_phone" className="form-label">Primary Contact Phone</label>
                    <input
                      type="text"
                      id="primary_contact_phone"
                      name="primary_contact_phone"
                      className="form-control"
                      value={company.primary_contact_phone}
                      onChange={handleChange}
                    />
                  </div>
                </div>
               
                <h3 className="mb-3">Documents</h3>
                <div className="row">
                  <div className="col-md-4">
                    <div className="mb-3">
                      <label htmlFor="certificate_of_incorporation" className="form-label">Certificate of Incorporation</label>
                      <input
                        type="file"
                        id="certificate_of_incorporation"
                        name="certificate_of_incorporation"
                        className="form-control"
                        onChange={handleFileChange}
                      />
                    </div>
                  </div>  

                  <div className="col-md-4">
                    <div className="mb-3">
                      <label htmlFor="gst_certificate" className="form-label">GST Certificate</label>
                      <input
                        type="file"
                        id="gst_certificate"
                        name="gst_certificate"
                        className="form-control"
                        onChange={handleFileChange}
                      />
                    </div>
                  </div>  

                  <div className="col-md-4">
                    <div className="mb-3">
                      <label htmlFor="pan_document" className="form-label">Pan Document</label>
                      <input
                        type="file"
                        id="pan_document"
                        name="pan_document"
                        className="form-control"
                        onChange={handleFileChange}
                      />
                    </div>
                  </div>  
                </div>

                <div className="text-end mt-4">
                  <button type="submit" className="btn btn-primary">Submit</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CompanyForm;
