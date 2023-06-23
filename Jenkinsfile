pipeline {
  agent any
environment {
VERSI="testing2"
}
  stages {
    stage('Checkout SCM') {
      steps {
        checkout([
          $class: 'GitSCM',
          branches: [[name: 'main']],
          userRemoteConfigs: [[
            url: 'git@github.com:adinugrohositp/testing.git',
            credentialsId: '',
          ]]
         ])
       }
    }
    stage('stop docker') {
      steps {
        sh '''#!/bin/bash
				ssh psii@10.242.104.141 "docker container stop sitp-report-tkd &"
             '''
      }
    }
    stage('remove existing docker') {
      steps {
        sh '''#!/bin/bash
				ssh psii@10.242.104.141 "docker container rm sitp-report-tkd &"
             '''
      }
    }
	stage('prepare workspace') {
      steps {
        sh '''#!/bin/bash
				cd /var/lib/jenkins/workspace/testingphp/
				rm -rf vendor
				composer install --ignore-platform-reqs
             '''
      }
    }
	stage('docker build and push') {
      steps {
        sh '''#!/bin/bash
        cd /var/lib/jenkins/workspace/testingphp/ && docker build . -t nginx-report-tkd:${VERSI} && docker tag nginx-report-tkd:${VERSI} tkddev2:89/re/nginx-report-tkd:${VERSI} && docker push tkddev2:89/re/nginx-report-tkd:${VERSI}
             '''
      }
    }
  stage('pull and run'){
    steps {
      sh '''#!/bin/bash
      ssh psii@10.242.104.141 "docker pull tkddev2:89/re/nginx-report-tkd:${VERSI} && docker run -it --restart=always --name sitp-report-tkd -d -p 7000:7000 tkddev2:89/re/nginx-report-tkd:${VERSI}"
           '''
    }
  }
  }
}
