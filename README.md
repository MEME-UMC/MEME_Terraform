# MEME_TERRAFORM
- MEME Terraform을 이용한 배포
<img src = "https://github.com/MEME-UMC/MEME_SERVICE/assets/52268188/31fbe9ba-ab6b-4ef7-8619-394b1186213f" width="30%" height="height 20%">

> **UMC 5기 프로젝트** <br/>

## 🖥️ 프로젝트 소개
MEME, 메이크업 모델과 아티스트 매칭 플랫폼
<br>
<img src = "https://github.com/MEME-UMC/MEME_SERVICE/assets/52268188/36da8e2c-d212-468f-a53c-89dacd1bd2ea" width="30%" height="height 20%">

## 팀 소개

|      임재영       |          김다은         |       김승엽         |    박선우       |                                                                                                    
| :------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | 
|   <img src="https://avatars.githubusercontent.com/u/55044278?v=4" width=90px alt="제이스(임재영)"/>    |                      <img src="https://avatars.githubusercontent.com/u/122000839?v=4" width=90px alt="돌리(김다은)"/>    |                   <img src="https://avatars.githubusercontent.com/u/61226778?v=4" width=90px alt="요비(김승엽)"/>   | <img src="https://avatars.githubusercontent.com/u/52268188?v=4" width=90px alt="썬(박선우)"/>
|   [@limjustin](https://github.com/limjustin)   |    [@daeun084](https://github.com/daeun084)  | [@yeopyeop-82](https://github.com/yeopyeop-82)  | [@sunwupark](https://github.com/sunwupark)
| 상명대학교 컴퓨터과학과 | 숭실대학교 컴퓨터공학과 | 상명대학교 컴퓨터과학과 | 경희대학교 컴퓨터공학과 |

## 🕰️ 개발 기간
* 24.02.15일 ~

## 시작 가이드

### Requirements
For building and running the application you need:

### Installation

``` bash
$ git clone https://github.com/MEME-UMC/MEME_Terraform.git
$ cd MEME_Terraform
$ fill in variables with right value
```
#### RUN
```
$ terraform init
$ terraform plan
$ terraform apply
$ terraform destroy
```

### ⚙️ 개발 환경
- HCL
- **Framework** : Terraform

### 아키텍처
<img src = "https://github.com/MEME-UMC/MEME_SERVICE/assets/52268188/312ea17c-a8b2-42c2-9e8c-dfd5bb8f3a1b" width="80%" height="height 60%">

## 📌 주요 기능
#### IAM: AWS Identity and Access Management은 AWS 리소스에 대한 액세스를 안전하게 관리하기 위한 서비스입니다.
#### EC2: Amazon Elastic Compute Cloud는 가상 서버를 제공하여 확장 가능한 컴퓨팅 파워를 제공하는 서비스입니다.
#### Route 53: Amazon Route 53은 신뢰성 높은 도메인 이름 시스템(DNS) 웹 서비스로, 도메인 등록, DNS 라우팅, 상태 확인 등을 제공합니다.
#### Certificate Manager: AWS Certificate Manager는 SSL/TLS 인증서를 쉽게 발급, 관리 및 배포할 수 있는 서비스입니다.
#### RDS: Amazon Relational Database Service는 관리형 관계형 데이터베이스 서비스로, MySQL, PostgreSQL, Oracle, SQL Server 등을 지원합니다.
#### ElastiCache: Amazon ElastiCache는 인 메모리 캐싱 솔루션으로, Redis 또는 Memcached를 사용하여 데이터베이스 및 웹 응용 프로그램 성능을 향상시킵니다.
#### S3: Amazon Simple Storage Service는 안전하고 확장 가능한 객체 스토리지 서비스로, 파일 및 데이터를 저장하고 검색할 수 있습니다.
#### API Gateway: Amazon API Gateway는 RESTful API를 쉽게 빌드, 배포 및 관리할 수 있는 서비스입니다.
#### Lambda: AWS Lambda는 서버리스 컴퓨팅 서비스로, 코드를 실행하고 서버 관리 없이 애플리케이션을 확장할 수 있습니다.
#### VPC: Amazon Virtual Private Cloud는 사용자가 정의한 가상 네트워크에서 AWS 리소스를 프로비저닝하고 격리시킬 수 있는 서비스입니다.
