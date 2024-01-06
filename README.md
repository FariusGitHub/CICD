Please refer to https://medium.com/p/12f5a9a7cf91/edit
for this https://github.com/FariusGitHub/CICD/ repo.

Please modify config file or you may tweak it later when Jenkins was started from Web UI.
Line 23, 39, 47 --> Put your Docker username
Line 23 --> put your Docker password

Also make a new file aws.credentials in the same folder
and enter your AWS access key and AWS secret key below.

{
  "access": "",
  "secret": ""
}

For install-packages.yml file, please consider these two

Line 63 on install-packages.yml may not upload properly.
You may consider to manually upload if this docker-compose.yml is missing.

Line 65 will normally go well if all above were completed.

****

This repo will demonstrate the simplest way to spin CI/CD with simple web app.
Jenkins and docker compose are the main tool for pipeline and orchestration.
