# Project Retrospective: What I Learned

Building this Olist dashboard taught me a lot, especially when it comes to visual design and how an end-user actually consumes data. Here are a few of the biggest realizations and takeaways I had while putting this together:

### 1. Plan ahead and let SQL do the heavy lifting
Because my final output was going to be a static presentation (meaning the charts don't need to be dynamically filtered by the user), I really should have done all my filtering directly in SQL. Instead, I brought the data into Power BI and found myself manually creating extra calculated columns and DAX measures just to get the specific numbers I needed for my visuals.

Although, of course, I wasn't able to 100% predict the information I'll be needing in Power BI, but as much as possible, perhaps plan the final output early, then let SQL do the heavy data shaping before it even touches Power BI to reduce the manual effort needed past the SQL stage.

### 2. Make the main point obvious immediately
When designing the logistics page, I had to carefully think about whether the viewer would get the main point with the least amount of effort required. At first, I almost settled for putting two horizontal bar charts side-by-side to compare Seller vs. Customer locations, and I knew something just felt really off:

<img width="2767" height="1600" alt="olist_ecommerce_dashboard-6" src="https://github.com/user-attachments/assets/9bea2102-f8cb-4711-849d-b2986c795402" />

Because São Paulo is the #1 state for both, side-by-side bar charts made the volumes look identical. Unless you squinted at the axes, you'd completely miss that there were over 41,000 customers but only 1,800 sellers. It required too much effort from the viewer and risked total misinterpretation. I decided to drop the charts entirely for this section and went with a formatted list instead, using large font sizes to make the exact numbers instantly clear.

### 3. Too many colors = confusing
I had another design struggle with the logistics page. In my first attempt at the maps, I tried using different colors for the customer and seller locations to emphasize that they were two different measures:

<img width="2767" height="1600" alt="olist_ecommerce_dashboard-5" src="https://github.com/user-attachments/assets/1fc14704-794e-49c4-be2d-0b9ed449edf8" />

I didn't know if it was just me (let me know lol), but upon trying to compare the two bubble maps against each other, I had a hard time in immediately finding the difference. A good dashboard should be able to deliver information in a quick scan, not have the viewer exert extra effort just to understand. And so this strategy completely backfired, created more visual noise, and made me significantly struggle to differentiate the two. In the end, I just used the exact same color for both maps. By taking away the contrasting colors, it's much easier to just focus on where there were bubbles, and where there were not.

### 4. Keeping code clean
I also realized how important it is to treat my code like a final product. Instead of just using my SQL script like a messy scratchpad, I wrote out a style guide and stuck to strict naming, aliasing, and commenting rules. It made reviewing my own work so much easier and makes the project much more readable for anyone else looking at my repo (well hopefully it does lol).

<br>

---

To anyone viewing this retrospective, please know that you are free to agree or disagree with my realizations. I am in no way forcing anyone to follow the takeaways I've written here; this simply serves as a diary entry to honestly document my personal experience, mistakes, and growth while making this project.
