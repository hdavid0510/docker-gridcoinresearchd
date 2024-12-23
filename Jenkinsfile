pipeline{
	agent any
	options {
		parallelsAlwaysFailFast()
	}
	environment {
		IMAGE_NAME="hdavid0510/gridcoinresearch-client-daemon"
		IMAGE_TAG='dev'
		REGISTRY_CREDENTIALS=credentials('dockerhub-credential')
	}

	stages {
		stage('Build images') {
			parallel {
				stage('linux/amd64'){
					steps {
						echo 'Building linux/amd64'
						sh 'docker buildx build --platform linux/amd64 -t $IMAGE_NAME:$IMAGE_TAG-amd64 .'
					}
				}
				stage('linux/arm/v7'){
					steps {
						echo 'Building linux/amd64'
						sh 'docker buildx build --platform linux/arm/v7 -t $IMAGE_NAME:$IMAGE_TAG-armv7 .'
					}
				}
				stage('linux/arm64'){
					steps {
						echo 'Building linux/arm64'
						sh 'docker buildx build --platform linux/arm64 -t $IMAGE_NAME:$IMAGE_TAG-arm64 .'
					}
				}
			}
		}
		stage('Push multiarch image') {
			steps {
				echo 'Dockerhub login'
				sh 'echo $REGISTRY_CREDENTIALS_PSW | docker login -u $REGISTRY_CREDENTIALS_USR --password-stdin'
				echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
				echo "Building ${IMAGE_NAME} on branch ${IMAGE_TAG}"

				echo 'Pushing multiarch image to DockerHub'
				sh 'docker buildx build --push --platform linux/amd64,linux/arm/v7,linux/arm64 -t $IMAGE_NAME:$IMAGE_TAG .'
			}
		}
	}
	post {
		always {
			sh 'docker logout'
		}
	}
}

