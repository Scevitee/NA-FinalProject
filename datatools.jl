using CSV, DataFrames

const ROOT_PATH = @__DIR__
const DATA_PATH = "$ROOT_PATH/data"


"""
get_datafiles(foldername::String)

takes in the name of a folder or path to subfolder in /data/
and returns an array of the paths to the different file names 


data_left_sideOf_center_dr = get_datafiles("Center/Left")

--> ["NA-FinalProject/data/Center/Left/Location-Justin-04-04", etc]
"""
function get_datafiles(foldername::String)
     filelist = readdir("$DATA_PATH/$foldername", join=true)
     return filelist
end



"""
get_folder_dataframes(foldername::String)

takes in the name of a folder or the path to a subfolder in /data/
returns a vector of all the dataframes in that folder



sweetwater_dataframes = get_folder_dataframes("Sweetwater")

"""
function get_folder_dataframes(foldername::String)
     filelist = get_datafiles(foldername)

     dfs = []
     for path in filelist
          data = CSV.File(open(path)) |> DataFrame 
          push!(dfs, data)
     end
     return dfs
end



"""
filter_matching_rows(dfs::Vector{Any}, column_name::String; round_to::Int=6)

takes in a vector of dataframes and a column to filter them by. It looks through the dataframes
and keeps rows in which the values match. Can specify how close you want values to be by 
using round_to to adjust the precision. Returns a vector of the resulting dataframes


filtered_dfs = (dfs, "latitude"; round_to=5)
"""
function filter_matching_rows(dfs::Vector{Any}, column_name::String; round_to::Int=6)
    # Ensure there is at least one data frame
    if isempty(dfs)
        error("The input vector must contain at least one data frame.")
    end
    
    # Ensure the column exists in all data frames
    for df in dfs
        if !(column_name in names(df))
            error("The specified column must exist in all data frames.")
        end
    end
    
    # Apply rounding and find the intersection of rounded values across all data frames
    rounded_values_sets = [Set(round.(df[!, column_name], digits=round_to)) for df in dfs]
    matching_values = reduce(intersect, rounded_values_sets)
    
    # Filter all data frames to only include rows with values (rounded) in the matching set
    filtered_dfs = [
        filter(row -> round(row[column_name], digits=round_to) in matching_values, df)
        for df in dfs
    ]
    
    return filtered_dfs
end



"""
get_filtered_points(dfs::Vector{Any}, column_name::String; round_to::Int=6, only_unique::Bool=true)

Takes in vector of dataframes generated by get_folder_dataframes. User specifies a column_name 
by which to compare the dataframes. Values are rounded 6 by default, but can be changed. 
The dataframes are trimmed based on these matching rounded values, and only the columns 
latitude, longitude, and altitude are returned. These are all that are needed for displaying the
points 


filtered_points = get_filtered_points(folder_dataframes, "latitude"; round_to=3)

"""
function get_filtered_points(dfs::Vector{Any}, column_name::String; round_to::Int=6, only_unique::Bool=true)
     filtered_dfs = filter_matching_rows(dfs, column_name; round_to=round_to)

     filtered_points = []

     for df in filtered_dfs
          map!(x->round(x, digits=round_to), df[!, column_name], df[!, column_name])
          new_df = select(df, ["latitude", "longitude", "altitude"])
          if only_unique
               unique!(new_df, column_name)
          end
          sort!(new_df, column_name)
          push!(filtered_points, new_df)
     end
     
     return filtered_points
end



"""
combine_df_vector(dfs::Vector{Any})

Takes in a vector of dataframes and combines them into one dataframe. It adds in a column titled "sample" to indicate which
data sample a given row comes from. 
"""
function combine_df_vector(dfs::Vector{Any})
     for i = 1:length(dfs)
          df = dfs[i]
          df.sample = fill("Sample $i", nrow(df))
     end

     a = dfs[1]
     for i = 2:length(dfs)
          append!(a, dfs[i])
     end
     
     return a
end