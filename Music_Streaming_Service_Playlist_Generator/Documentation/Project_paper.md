![project coldlight cover](./Images_Music_Streaming_Service/Project_Coldlight_Cover.jpg)

*“Music is a cross-cultural universal, a ubiquitous activity found in every known human culture. Individuals demonstrate manifestly different preferences in music, and yet relatively little is known about the underlying structure of those preferences.”* (Rentfrow et al. 2012).


A group effort by:  
Tommy Baw  
Jack Benischeck  
Jordan McIntyre  
Shachi Parikh  
Chang Wang  
Xiaomeng

# Foreword 

*The name Coldlight is a fictitious music streaming company we came up with for the purposes of this project. It is not a registered or trademarked name, and any likeliness to a real company is purely coincidental. This is simply meant as a vehicle for discussion and analysis of the EMI music data found on the website Kaggle (full references and credit to the data are given in the bibliography). To that end, any references to partnerships with EMI Records are purely fictitious.*



# Case Study

Since the introduction of the infamous Napster in 1999, the Internet has become the premier place for music listening. Though Napster was forced to close its doors on its file-sharing business, the precedent for free music was set, with an altered business model. In return for a listener’s willingness to hear a few advertisements, streaming companies let users play songs free of charge. This strategy has proved profitable, as music streaming companies such as Songza and Tidal have been valued and acquired for millions of dollars. The key to this model is to grow the base of listeners.

We, the employees of the music streaming service Coldlight, have been tasked with creating a new radio station for first time users of Coldlight that will immediately attract them to use our services. Our company is having significant internet traffic on the landing page, but time spent on our site is short. Users typically leave before trying a demo of our services. We believe that the site, though having much to offer, is being written off by the user. However, users that spent extended time on our site were significantly likely to return to listen to music at another date.  In other words, when given a shot, users seem happy with their experience; it is the first impression that is causing issues. 

To help solve this problem, we will analyze data from the EMI music challenge, posted on Kaggle in 2012, prior to their purchase by Sony. Our study will be concerned mainly with the Words and Users datasets. These datasets will allow us to understand more about music listeners and their preferences, so we can make a more positive first impression. We want to minimize the probability that a user will be lost by an initial impression. Working under that principle, it is easier to avoid saying the wrong thing than it is to say the perfect thing. Therefore, we are attempting to minimize playing the wrong type of music to different demographics. A playlist with only approved artists from a selection of those signed to the EMI label (sponsor of Coldlight) will be initially offered to each distinct group of listeners. 

EMI did not provide artist names in their datasets. The artist information is de-identified where artists’ are labeled 00 to 49. This data also comes with what listeners thought of those artists based on 82 different words.  We will approach the project based on the work of Rentfrow et al. by performing a cluster analysis on the descriptive words to determine which words commonly appear with one another via sentiment analysis. 

Once the clusters are obtained, the next step is to connect these clusters with different age groups and genders, to determine what they thought of each artist. Although more information than age and gender are provided in the data, we will exclude it. While other streaming services such as Pandora ask listeners for songs or artists they like as a starting point, we want to make the experience of arriving on our site and listening to music simpler and quicker. This practice is common among other streaming sites, such as Spotify.
	
To pair artists and users, we will examine the profiles (i.e., sentiment analysis) of the top five most liked artists of each age group for both male and female listeners. Using this information, we minimizes the probability that a new user's initial experience is negative while still ensuring a station that has some musical diversity and charactistics of each groups preferred music types. 



# Managerial Report

As you know, Coldlight faces the challenge of acquiring new users, despite our high retention rate of existing users. The main problem we identified is that our sign-up and initialization procedures take too long for new users. They leave our website either during the sign-up phase or during the period of searching for artists to customize their playlists. 

To counteract this, we have designed a two-step solution. First, we have streamlined the sign-up process. While we ask for the standard username, password, and email address, we only ask two additional questions: the user’s gender, and their birthday. With these two pieces of information, we can build each new listener a custom playlist of music which they are predicted to like. This playlist is available to the user as soon as they log in for the first time, offering gratification much sooner.  Thus, the user will increase their time on our site as they become better acquainted with our service.

To build the custom playlists, we first reviewed research regarding the aspects of individual music tastes and preferences. We found that music tastes can be generally broken down by age, as well as gender. For instance, Paul Lamere, a data analyst, looked at 200,000 Spotify users and found more than a 30% difference among males and females in most-liked artists and their genres. Based on these reports, we chose these two points to be the only questions for our sign-up, as well as our decision model.

These assumptions for our model made our partnership with EMI Records an excellent choice. The data they provided allowed us to view over 32,000 users and their sentiment towards 50 artists. While the data contained many additional users, we chose to focus on the groups who were familiar with the artists they reviewed. Therefore, the dataset we analyzed contained the individual user, their age, gender, a Likert score of the artist, and the words they used to describe that artist.

From this dataset, we clustered similar words into 10 sentiments for each artist broken down by males and females.  We further broke down the data into the average sentiment weight for each age group by sex. This was done for the top 5 most liked artist for each age group and sex (reference Figure 3.2 in the Appendix). When compared to the overall sentiment average by gender, we can pinpoint which sentiments matter to each age group. With this, we have built support for our model.

The model, then, is simply to minimize the sum score of sentiment categories least liked for each age group and gender. By minimizing traits least desired by each group, we can populate a custom playlist with artists they will enjoy. To further ensure that the new user likes the playlist, we included stipulations that sentiments important to each age and gender group are emphasized, along with requirements for diversity among artists. 

The final result is a set of 14 playlists, broken down by male and female across 7 age groups, as shown below. They are made to consider how each age group and gender feel about music, based on the information they provide us while signing up. Through an easier sign-up, and immediate sampling of our service, we anticipate a higher percentage of site visitor conversions to users. Please refer to the deck in the appendix for updates to the UI.



# Technical Report

Our decision support system focuses on how we can minimize the likelihood of putting a disliked artist on a new user playlist, based on that user’s age and gender. Specifically, our goal is to select corresponding artists to minimize the total comparative preference rates for the least-liked sentiment of the particular age and gender group. The optimal playlist will be diversified to include artists in different sentiment categories, with a focus on those with higher, desirable sentiments. 

In general, we included the following constraints in our model:
- Total artists in the music playlist is 8.
- For the three most preferred music sentiments based on the age group and gender, the average comparative preference rate of each sentiment in our playlist should be at least the average level of the preference rate of top 5 preferred artists.
- For the second least preferred sentiment based on the age group and gender, the average comparative preference rate in this sentiment in our playlist should not exceed the average level of the preference rate of top 5 preferred artists.
- For the moderately preferred sentiments (4th to 8th) based on the age group and gender, we should each at least include one artist whose preferred weight in the category is higher than the average level of the category.
- To ensure diversity, for the ten categories, the total number of artists with high preferred rate based on the age and gender should not exceed 5.
- The total scores based on the age group and gender should be at least 1.2 times the average scores based on the age and gender.

A solution to one of the 14 possible outcomes is shown below. For the age 1 group and gender male, we include artists 16,18,19,20,34,35,37,38 in our playlist. 

![SAS Output](/Music_Streaming_Service_Playlist/Images/Sas_Output_1.jpeg)

To reach this model, we first had to analyze the datasets given to us by EMI, in accordance with our research findings on how age and gender cause differences in musical taste and preference. We eliminated any values of missing gender, to create the binary decision of male or female. Likewise, we removed any missing ages. based upon a study carried out by Arielle Bonneville-Roussy from Cambridge’s Department of Psychology, we divided age into 7 groups:

13-17 years  
18-24 years  
25-34 years  
35-44 years  
45-54 years  
55-64 years  
65 and Above  


Research shows that musical tastes shift as we age are in line with key "life challenges." Teenage years were defined by "intense" music, then early adulthood by "contemporary" and "mellow" as the search for close relationships increases, with "sophisticated" and "unpretentious" allowing us to project status and family values later in life. This study used data from more than a quarter of a million people over a 10 year period.


While reviewing the EMI data, it became apparent that many words were synonyms and that a cluster analysis could be performed to find naturally occurring patterns within the words. A spreadsheet was created giving a total count of words used to describe each artist. From there, a cluster analysis was performed to reduce the amount of similar words.  Several clustering methods were performed to confirm we not only had the best fitting dendogram, but also the words in each cluster were similar in nature. Ultimately the Ward Method was used to produce the clusters below (dendogram in appendix…)


Timeless{Classic Timeless}  
Talented{Distinctice Good Lyrics Talented Original Authentic}  
Emotional{Dated Depressing Inspiring Serious}  
Ambient{Calm Warm Beautiful Approchable Credible Stylish Passionate Toughtful}  
Teenage{Energetic Upbeat Fun Current Youthful Boring Cool Confident None of These Edgy}  
Pop/Top 40{Annoying Sexy Playful Trendsetter Outgoing Unoriginal Cheesy Superficial Fake Cheap Unattractive Noisy Arrogant Aggressive}  
Least{Popular Free Rebellious Outspoken Genius Intriguing Exciting Colourful Uplifting Sociable Emotional Heartfelt Soulful Relaxed Laid Back Background Sophisticated}  
Classic Rock{Iconic Nostalgic Dark Legendary Superstar Way out Progressive Pioneer Old Wordly Wholesome}  
Lame{Unapproachable Over Relatable Intrusive Not Authentic Irrelevant Mainstream Uninspired}  
Catchy


Using this sentiment analysis, we were able to name each of the 10 clusters produced from the original 82 words. The decision was made to leave catchy as its own cluster as it was the most used word across all artists. For the rest, names were given based on the emotion or music-style that the words described. For example, music that was calm, warm, beautiful, approachable, credible, stylish, passionate, and thoughtful pertained in our opinion to ambient music. The category Least is our largest cluster and we gave it this name as several of these words were used sparingly in the survey and thus the words in this cluster might not appear to belong together at first glance.

Now that we have 10 meaningful clusters, we can find the percentage of each cluster used to describe the artists. From this information we can now work towards our preference algorithm. Since the algorithm considers age and gender, we split the data of cluster breakdown per artist to both male and female users. We then take the likability score that the users filled out to take the five highest scores to see what words users (male or female) are using to describe the favorite artists of each age group. Take for example figure 3.2 below that only shows a portion of our data for clusters “Timeless” and “Talented”. We  will look at the data highlighted in orange where AG1M represents all male users between the ages of 13 and 17 that gave a likability score for artists and they gave artists 18, 28, 29, 11, and 40 the highest average rating. We calculate 0.0157722 from the average weight that all male users used words in the timeless cluster for those 5 artists. If you divide this by the overall weight that male users put into Timeless (0.0560719), we get the table listed as figure 3.3. For AG1M, they place only 28.13% importance towards artists that can be classified as producing timeless music. On the other hand, they enjoy music listed under the “Teenage” category 146.79% of the time compared to other users. Figure 3.3 has been color coordinated for ease of use where green represents the category of music that a certain age group puts an emphasis and red for their least enjoyed type of artist.


| | | Artist1 | Artist2 | Artist3 | Artist4 | Artist5 | Timeless | Talented |
| -- | -- | ----- | ------| ----- | ----- | ----- | ----- | -----| 
| 1 | AG1M | 18 | 28 | 29 | 11 | 40 | 0.0157722 | 0.1888658 |
| 2 | AG1F | 11 | 26 | 17 | 35 | 40 | 0.0219846 | 0.1706131 |
| 3 | AG2M | 49 | 40 | 17 | 11 | 9  | 0.0247139 | 0.1536077 |
| 4 | AG2F | 17 | 40 | 19 | 11 | 6  | 0.0175559 | 0.1685359 |
| 5 | AG3M | 19 | 4  | 23 | 35 | 22 | 0.060654  | 0.2406601 |
| 6 | AG3F | 5  | 43 | 44 | 34 | 4  | 0.0589015 | 0.2468483 |
| 7 | AG4M | 29 | 7  | 4  | 22 | 34 | 0.0722811 | 0.242749  |
| 8 | AG4F | 17 | 43 | 8  | 31 | 44 | 0.0261049 | 0.1807106 |
| 9 | AG5M | 7  | 22 | 4  | 21 | 6  | 0.0838473 | 0.2472319 |
| 10| AG5F | 15 | 43 | 26 | 29 | 7  | 0.0504046 | 0.215482  |
| 11| AG6M | 4  | 22 | 7  | 35 | 49 | 0.0795477 | 0.2451082 |
| 12| AG6F | 29 |  4 | 9  | 36 | 44 | 0.0729278 | 0.206394  |
| 13| AG7M | 4  | 43 | 21 | 14 | 23 | 0.0610645 | 0.246383  |
| 14| AG7F | 15 | 27 | 30 | 21 | 4  | 0.0498588 | 0.1929626 |
| 15|AGNAM | 1  | 30 | 26 | 29 | 2  | 0.0506945 | 0.1977143 |
| 16|AGNAF | 0  | 30 | 28 | 27 | 29 | 0.0292231 | 0.191369  |
| 17|AGNANA| 38 | 23 | 40 | 6  | 48 | 0.0255178 | 0.1449652 |
|Average Males|||||||0.0560719|0.22029|
|Average Females|||||||0.0408702|0.1966144|
|Total Average|||||||0.0471208|0.2047177|
|Average over all artists|||||||0.0353614|0.1602547|

*figure 3.2*


![figure 3.3](/Music_Streaming_Service_Playlist/Images/Figure_3.3.jpeg)

*figure 3.3*
