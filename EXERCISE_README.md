Hi !

This is an off-site test for Backend Engineer in the process of joining the comet team.

# Context

At comet, we handle thousands of freelancers, each freelancers has several professional experiences populated in their profile.

We use these professional experiences in our matching algorithm to match the freelancer with the most relevant experience to the mission.

You can find an example of a mission and of a freelancer data model in the `/examples` folder.

# Exercise

In our matching algorithm, we use the total months of experience of each skill for each freelancer.

If you look at the example `example/freelancer.json`, you will see that the freelancer has 3 professional experiences, you can see that he has been doing Javascript since his first professional experience, in may 2013 and kept doing Javascript until his last professional experience in may 2018.

We would like to compute the **total number of months** the freelancer has worked for **each skill**.

You will have to read the data from `exercise/freelancer.json`, it will have the same structure as `example/freelancer.json`.

The result should be formatted in JSON with this exact structure on the standard output :

```
{
    "freelance": {
        "id": 42,
        "computedSkills": [
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
                "id": 370,
                "name": "Javascript",
                "durationInMonths": 60
            },
            {
                "id": 400,
                "name": "Java",
                "durationInMonths": 40
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

# Rules

1. Overlapping months of experience with the same skill(s) should not be counted twice, see [assets/months-overlap.png](./assets/months-overlap.png)
2. All professional experiences `startDate` and `endDate` values will be on the first day of the month.
3. You script will be executed like this : `node exercise.js`
4. We're using node 8.11.3 for the execution
5. You can use any npm package you want
6. If there's an error in the json file, exit without printing anything
7. The duration in months should be rounded

# What's evaluated

1. Cleanliness & structure of the code
2. Problem solving
3. Documentation
4. Use of tests
5. Smart use of Node.js library and packages
6. Respect of KISS and DRY principles
7. Use of git commits

# How to

1. Fork the repo or clone it if you don't have a Github account
2. Do the exercise
3. Give us your fork URL or send us an archive file containing your work
