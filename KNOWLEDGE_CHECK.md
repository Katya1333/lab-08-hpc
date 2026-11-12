# Lab 08: Knowledge check

**Answer each question below it, in your own words, in one to three sentences.** Replace the `...` below **Your answer:** with your text. Questions 1 and 3 also ask for saved output, which goes into the directory `results/`.

## 1. Slurm: what jobs have I submitted?

**Your task:** print a history of all your Slurm job submissions *since November 4, 2026*. Format the output to include the job ID, job name, node list, partition, account, user, state, start time, and elapsed time. See the job accounting fields in the [sacct documentation](https://slurm.schedmd.com/sacct.html). You may also ask Claude Code or another LLM for the exact command. 

Redirect the command's output to `results/job-history.txt` and include the file in your submission. Do not worry if some earlier jobs failed or were canceled. The complete history should show your process, including trial and error.

*Hint:* See [Part 1, Step 6](README.md#step-6-check-how-the-tasks-ended) in the README.

**Your answer:** Provide the entire command you used, including all CLI options.

sacct -u $USER -S 2026-11-04 --format=JobID%20,JobName%15,NodeList%15,Partition,Account,User,State,Start,Elapsed > results/job-history.txt

## 2. Slurm: did every array task run at the same time?

You submitted your entire job array with one `sbatch` command, but Slurm scheduled each task separately.

**Your task:** in the job history from Question 1, find the tasks from your most recent completed array run. Compare their start times and elapsed times.

*Hint:* See [Part 1, Step 5](README.md#step-5-watch-the-job-array) in the README.

**Your answer:** Did all tasks in the array start at the same time? Was the elapsed time identical for every task? Explain why or why not.

No, not all tasks started at the same time. However, you can observe that certain chunks of tasks started at the same time and ended after a certain amount of seconds. In general, the chunks seemed to be about 24 tasks at a time, and they took anywhere between 16 and 22 seconds. So, the elapsed time was not identical for every task.

## 3. Slurm: did my job use what it asked for?

Suppose your next job array has 1,000 books instead of 101. Before you submit it, you want to know whether your script asks for too much or too little memory and time.

**Your task:** run `seff` for **one** task of your finished job array, and save its output as `results/seff.txt`.

*Hint:* `seff` takes the ID of one task, such as `4211873_1`. Compare its **Memory Utilized** and **Job Wall-clock time** with `--mem` and `--time` in your `summarize.slurm`.

**Your answer:** How much memory and time did the task use, compared with what your script asked for? What would you change in your script, and why?

I got this result:
Job Wall-clock time: 00:00:20
Memory Utilized: 1.91 GB
Memory Efficiency: 11.95% of 16.00 GB (16.00 GB/node)

Thus, the task used 1.91 GB of the 16 GB I requested with --mem=16G (11.95% memory efficiency), and its wall-clock time was 20 seconds of the 5 minutes I allowed with --time=00:05:00 (about 7%). So my script asked for much more memory and time than the task needed. Thus, I would change --mem to 4G and --time to 00:01:00 because 4G is much lower than 16G, but still safe because it is still more than two times 1.91, and 1 minute is five times less than 5 mintues while still being five times more than the expected 20 seconds. So, it is also safe. 
