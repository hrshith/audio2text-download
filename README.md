## This project implements the Whisper AI models in an easily accessible and simple to use containerized Web App.
## No need to mess with config files and pip dependencies, everything comes packages in a single docker container ready to be used. 
## And you can run using deploying with Terraform in the different cloud provider and I am using AWS in this project


## Check out the project on Docker Hub - [Docker Hub](https://hub.docker.com/repository/docker/asharshith/audio2txtdowload/general)

# ***Repository Overview***:

This repository hosts a Flask web application integrated with Audi2Text for speech-to-text functionality, Whisper messaging for secure communication, and a feature for downloading text. The README provides instructions on running the application.

**Docker Hub Overview:**

This Docker image contains the Flask app configured with Audi2Text and Whisper messaging capabilities. It simplifies deployment and offers flexibility for various environments. 

**Why This Image:**
This image provides a convert setup for a  Audi2Text integration using python Flask app and Whisper messaging services enabling easy deployment and utilisation of audio-to-text and secure messaging  and download features.

**Overview:**
This Docker image facilitates the deployment of a Flask app with Audi2Text integration and Whisper messaging, streamlining the process of setting up a web application with advanced functionalities. It serves as a foundation for building speech-to-text enabled applications with secure communication capabilities.


**Getting Started**

These instructions will get you a copy of the project up and running on your local machine and developement server for a development and testing purposes.


**Pre-requisites:**
- Docker installed on the host machine or server 

**Deployment Options:**
- Docker container only 

### How to use this image

The container runs on port 5000, launch and run it using the below command.

```
docker run -d --name=audio2txt -p 5000:5000 asharshith/audio2txtdowload:v1.0.0
```
### Browse to http://your-host-ip:5000 to access the web UI

# Building it yourself

You can also build the container locally. Just clone this repository
```
git clone https://github.com/hrshith/audio2text-download.git 
```

Then change into the directory
```
cd audio2txt-download
```

Build the container
```
docker build -t audio2txt-download
```

Finally once the container is build you can launch it using the command 
```
docker run -d --name=audio2txt -p 5000:5000 audio2txt-download
```


# Deploying Using Terraform

  **Install Terraform:Visit the Terraform website to download the appropriate version for your operating system  After downloading, follow the installation instructions below**.

## Create Terraform Configuration File: And its avalible in the infrastructure.tf file formate 

## **User

In the infrastructure.tf file, specify the essential resources for my application, including Docker images and their Docker Hub details. Additionally, deploy an AWS EC2 instance with appropriate configuration and specifications, as outlined in the provided statement. Detailed instructions can be found in this readme file

The code avalible in my infrastrucute.tf file its creates an EC2 instance with a high end version using terrafrom script.

# Initialize Terraform: Before applying any changes, you need to initialize Terraform in directory containing your configuration files, Run the following command:

```bash
terraform init
```
To run the below cmd to see what changes Terraform will make to your  AWS infrastructure .
```
terraform plan
```
To run the below apply cmd to enact changes to your AWS infrastructure based on the configured plan.
```
terraform apply
```
*Confirm changes: Terraform will prompt you to confirm the changes before applying them. Review the changes carefully and type yes to confirm and proceed*

# Managing Terraform State Securely
It's crucial to manage your Terraform state file securely, especially in shared environments like EC2 instances. Storing your state file locally is not recommended, as it poses security risks and makes collaboration more challenging.

We highly recommend using remote state management to securely store your Terraform state file. Services like Terraform Cloud, AWS S3, or HashiCorp Consul are commonly used for this purpose. Ensure proper access controls are in place to restrict who can modify the state.

For more information on Terraform state management, refer to the official documentation.

# Additional Notes

## The container runs the base model of Whisper by default, if you want to change it, follow the instructions below. (For future builds I am hoping to incorporate this into the docker run command)

1. Once the container is running, enter it
   ```
   docker exec -it audio2txt-download bash
   ```
2. Look for the **text.py** file and open it (You can install and use an editor of your choice I am using nano)
   ```
   nano text.py
   ```
3. You should see the below line
   ```
   # Load the Whisper model
   model = whisper.load_model("base")
   ```
4. Change it to anything you like based on the below table (The .en models are english only)

5. For example if you want to run the medium model your code should look like this.
   ```
   # Load the Whisper model
   model = whisper.load_model("medium")
   ```
6. Just restart the container and upload your audio and it will automatically pull the new model.


**Warning: Higher models require a moderately powerful CPU else it will take forever to load**

|  Size  | Parameters | English-only model | Multilingual model | Required VRAM | Relative speed |
|:------:|:----------:|:------------------:|:------------------:|:-------------:|:--------------:|
|  tiny  |    39 M    |     `tiny.en`      |       `tiny`       |     ~1 GB     |      ~32x      |
|  base  |    74 M    |     `base.en`      |       `base`       |     ~1 GB     |      ~16x      |
| small  |   244 M    |     `small.en`     |      `small`       |     ~2 GB     |      ~6x       |
| medium |   769 M    |    `medium.en`     |      `medium`      |     ~5 GB     |      ~2x       |
| large  |   1550 M   |        N/A         |      `large`       |    ~10 GB     |       1x       |




7. Access the application at `http://localhost:5000` after running the Docker container.





# Credits
Special credits go to the OpenAI Whisper project which has made this project possible! Check them out at - [Whisper Project](https://github.com/openai/whisper)


**References:**
- **Flask**: https://flask.palletsprojects.com/en/3.0.x/

- **Whisper**: https://github.com/openai/whisper/blob/main/README.md

- **Docker**: https://docs.docker.com/reference/dockerfile


