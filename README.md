## Run it

### Run via Docker
Running this code with Docker should be easier and faster. _You should have Docker installed._
1. Build:
```
docker build -t kuaaaly/backend-engineer-test:0.1 https://github.com/Kuaaaly/backend-engineer-test.git
```
2. Run:
```
docker run -it kuaaaly/backend-engineer-test:0.1 /bin/bash
```
3. Once you are in you can run the code by typing :
```
cd /root/backend-engineer-test
./exercice.sh
```
The output should look like the following:
```
{
  "freelance": {
    "id": 42,
    "computedSkills": [
      {
        "id": 400,
        "name": "Java",
        "durationInMonths": 40
      },
      {
        "id": 370,
        "name": "Javascript",
        "durationInMonths": 60
      },
      {
        "id": 241,
        "name": "React",
        "durationInMonths": 28
      },
      {
        "id": 270,
        "name": "Node.js",
        "durationInMonths": 28
      },
      {
        "id": 470,
        "name": "MySQL",
        "durationInMonths": 32
      }
    ]
  }
}
```

### Run via Ubuntu (not tested)
Requirements:
- bash version 4.4.19
- jq version 1.5-1
- git


| Ubuntu |
|---|
| `apt-get install git jq` |

Then:
```
git clone https://github.com/Kuaaaly/backend-engineer-test.git
cd backend-engineer-test
./exercise.sh
```

## Criticize it

1. This part of the code:
``` bash 
var=$(declare -p "$1")
eval "declare -A _arr="${var#*=}
```
is repeated 3 times, this is not "DRY-compliant". I looked for a while for a way to integrated it in a function but I did not find a solution for now. May be there is not...

2. Actually, the script need the experiences to be ordered by startDate (from the most recent to the oldest). If the experiences are not well ordered the script will compute wrong values. This problem is pretty easy to fix if we add a function  ordering the experiences.

3. Skills in the result are not ordered by id, we could had something to display them by ascending or decreasing order
