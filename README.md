# aws-command-line-tools

Some tools I use to manage AWS.
Most of the things in this repo are mean to put in your ```.bash_profile``` or ```.zsh_profile``` to have a set of commands tools to setup a correct environnement.

## awsTokens
If like me your aws token has MFA activated you need to use it on command line as well.
Function awsTokens perform the MFA and put in env variables your ```AWS_ACCESS_KEY_ID```, ```AWS_SECRET_ACCESS_KEY``` and an ```AWS_SESSION_TOKEN``` to use the aws command line.

### How to get my MFA arn
To get You MFA ARN you need to have your AWS cli configure _(aws configure is your friend)_.  
After that you can use :
```sh
$ aws iam list-virtual-mfa-devices
> 
...
    {
        "SerialNumber": "arn:aws:iam::XXXX:mfa/Thomas",
        "User": {
            "Path": "/",
            "UserName": "Thomas",
            "UserId": "XXXXXXX",
            "Arn": "arn:aws:iam::XXXXXX:user/Thomas",
            "CreateDate": "2019-09-13T09:38:48Z",
            "PasswordLastUsed": "2019-09-13T11:01:58Z"
        },
        "EnableDate": "2019-09-13T09:47:05Z"
    },
...
```
In the result you need to find your account and to get your arn from that.
What you are looking for is the SerialNumber.
    
### Install it on your command line
Copy the awsTokens file in your ```~/.bash_profile``` or in your ```~/.zsh_profile```.
Load the new file :
```sh
$ source ~/.bash_profile
or 
$ source ~/.zsh_profile
```
You are ready to use it.

### Example of Usage 
First param is you ARN and second your MFA code.

```sh
$ awsToken arn:aws:iam::XXXX:mfa/Thomas 644957 
```

