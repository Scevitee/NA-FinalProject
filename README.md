# NA-FinalProject

## Datatools

I spent a good amount of time understanding the data and how to process it. To make it so you don't have to do the same, I've developed some functions to speed up process. In order to use the functions I've made, simply use

```julia
include("path/to/datatools.jl")

```

For example, if I was working in the src/cubic_1d folder, datatools.jl would be located two directories back

```julia
include("../../datatools.jl")
```

This isn't the cleanest solution ever, but it should work for our project

Every function created in the file has a docstring, which should allow you to use `?FUNCTION_NAME` to figure out how to use it.



## Function demos

#### `get_folder_dataframes(foldername::String)`
This automatically looks for files contained within data/ , so no need to input weird filepaths. Simply input a string for the folder or subfolder. 
**Note:** This only works if all the files contained are CSVs, and it is indiscriminant towards which CSVs it grabs, so only include the Location.csv files exported by `Sensor Logger` in the data folders

This will return a vector of dataframes, one for each CSV file in the folder.

```julia

left_centerdr_dfs = get_folder_dataframes("Center/Left")
sweetwater_dfs = get_folder_dataframes("Sweetwater")

```

I've refrained from having every function just take in a folder name and then complete all the operations needed from that point. I've done this because each dataset may require a bunch of manipulations / need to exist in different forms, which may be lost otherwise.

---

#### `filter_matching_rows(dfs::Vector{Any}, column_name::String; round_to::Int=6)`

For some of our comparisons, we will want all the dataframes in the vector to contain datapoints gathered at the same coordinates. This function goes through a specified column and will keep rows in the different dataframes that have similar values. Note that this does not guarantee that the resulting dataframes will be the same size. For example. Say dataframe 1 `df1` has a column (say latitudes) with values  `[1.0, 1.0, 1.2, 1.3, 1.4]` and `df2`'s column is `[1.0, 1.2, 1.5, 1.6]`

`df1`'s column will now look like `[1.0, 1.0, 1.2]` while `df2`'s looks like `[1.0, 1.2]`

The numbers contained in each are all the same, but the vectors are of different sizes. Since we are tracking our position using a sensor, it may record two points as having the 'same' latitude, which really just means we haven't moved far enough for it register two different locations. 

```julia
sweetwater_filtered_dfs = filter_matching_rows(sweetwater_dfs, "latitude")
```

 
---

#### `get_filtered_points(dfs::Vector{Any}, column_name::String; round_to::Int=6, only_unique::Bool=true)`

This is similar to the last function, but setting `only_unique=true` removes the issues of different dataframe sizes. This also trims the dataframes to only contain the columns "latitude", "longitude" and "altitude". These are the only ones really necessary for plotting (I think?). It also sorts the dataframes based on the provided column, which is nice for comparing samples. Imagine recording data for the same road, but on one trip you walk south, and the other you walk north. The exported data will be reversed for the two.

```julia
sweetwater_df_points = get_filtered_points(sweetwater_dfs, "latitude")
```

I prefer working with the data as separate dataframes, I like the freedom I have to apply different plot attributes to it / work on the different samples individually. Sometimes, however, it can be easier instead to visualize the data as a single larger dataframe instead of multiple smaller ones.

---

#### `stack_df_vectors(dfs::Vector{Any})`
This stacks all the dataframes in a vector into one. It also adds a new column to the dataframe titled `sample`. Items coming from the first vector will be labeled as 'sample 1', items from the second will be 'sample 2', and the pattern repeats for every index of the original vector. This allows for some simple but quick plotting

*I'm using the filtered points here but you don't have to*

```julia
sweetwater_single_filtered_df = stack_df_vectors(sweetwater_df_points)

# I don't feel like typing that var name a bunch of times
ssfd = sweetwater_single_filtered_df

plot(ssfd.latitude, ssfd.altitude, group=ssfd.sample)
```
![](assets/samples_demo.png)

This automatically finds all the rows that belong to Sample1 and Sample2 and plots them on the same diagram