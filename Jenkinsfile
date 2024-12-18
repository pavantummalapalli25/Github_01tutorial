pipeline {
  agent any
  stages {
    stage('') {
      steps {
        sh '''#!/bin/bash

# Variables
JENKINS_URL="http://localhost:8080"
JOB_NAME="MyJob"
CONFIG_XML="config.xml"
USER="your_username"
API_TOKEN="your_api_token"

# Create a new job
curl -X POST "${JENKINS_URL}/createItem?name=${JOB_NAME}" \\
  --user "${USER}:${API_TOKEN}" \\
  --header "Content-Type: application/xml" \\
  --data-binary "@${CONFIG_XML}"

echo "Job ${JOB_NAME} created successfully."
'''
      }
    }

  }
  environment {
    job = ''
  }
}