# About the Project

This Project will build and public rest api and a backend in Amazon WebServices (AWS) cloud which which can find and replace certain strings.
ex: 
Example input: “We really like the new security features of Google Cloud”
Expected output: “We really like the new security features of Google© Cloud”


This will create the following resource
* IAM Roles
* AWS Lambda Function
* Cloudwatch Log group for the Lambda
* API gateway - Rest API
* API gateway resource and method
* API gateway Deployment
* API key for accessing the api gateway


&nbsp;

# Built with
This project is mainly built with terraform version 13.7</br>
It will leverage the AWS serverless capabilities and will deploy resources on AWS cloud.

&nbsp;

# Getting started
To run this solution successfully, you should follow the below steps

&nbsp;

You need to install terraform 13.7</br>
</br>
Please Visit the below link to download terraform </br>
.[Download Terraform]: https://releases.hashicorp.com/terraform/0.13.7/

</br>
Please Visit the below link to install terraform </br>
[Install Terraform]: https://learn.hashicorp.com/tutorials/terraform/install-cli

&nbsp;

# Usage
Please follow the instructions in the below steps to run the solution

* Follow the steps in getting started section thoroughly
* Refer to the **description** section in **variables.tf** for all the variables that need to be passed.
* create and pass the aws credentials to variables **access_key** and **secret_key**
* pass the aws region to the variable **region**
* run the below commands to execute terraform


Initialize terraform
``` terraform
terraform init
```
Create a plan of all the resources that are to be deployed to aws and verify before execution
``` terraform
terraform plan
```
you can use the below command to create all the resources
``` terraform
terraform apply
```
you can also use the below command to destroy all the resources
``` terraform
terraform destroy
```

&nbsp;

# Techinical Notes
 * This solution also uses terraform s3 bucket to store state files.
 * The solution also include the lambda_function code as lambda_function.py
 * This solution also has a CD/CD pipeline build with github action.
 * Incase you need to push any code changes, then follow the below steps
  1. Make changes to lambda_funcion.py
  2. make changes to .github/main.yml and change the code push env variable version. This will push the code to the respective S3 path
  3. use the same verion in the terraform variables lambda_code_s3_bucket_key point the lambda to the new code.
 * In case you need to pass more replacer words, then append it the string value of variable replacer_words
&nbsp;
* to call the API, refer to the outputs api_invoke_url + api_resouce_name and do not forget to pass the x-api-key as the header for which value can be picked up by referring to the output variable api_key_value
* pass the string that has to be replaced with new values as the request body of the api

# contributing
If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request to the main branch

&nbsp;

# Acknowledgement
https://aws.amazon.com/api-gateway/ </br>
https://aws.amazon.com/iam/ </br>
https://aws.amazon.com/lambda/</br>
https://www.terraform.io/intro

