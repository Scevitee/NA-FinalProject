using Pkg;
Pkg.activate(".")
Pkg.add(["KeplerGL", "Colors", "ColorBrewer", "CSV", "DataFrames"])
using KeplerGL, Colors, ColorBrewer, CSV, DataFrames
include("../../datatools.jl")

all_dfs = get_all_dataframes();

df = stack_all_streets(all_dfs);

token = KEPLER_TOKEN;
m = KeplerGL.KeplerGLMap(token, center_map=false)

# KeplerGL.add_point_layer!(m, df, :latitude, :longitude,
#      color=colorant"rgb(23, 184,190)", color_field= :altitude,
#      color_scale = "quantile", 
#      color_range=parse.(Colorant, ["#5A1846","#900C3F","#C70039","#E3611C","#F1920E","#FFC300"]),
#      radius_field = :altitude, radius_range = [1, 8], radius_fixed = false,
#      filled = true, opacity = 0.2, outline = false);

# m.config[:config][:mapState][:latitude] = 29.64295270113718
# m.config[:config][:mapState][:longitude]= -82.34723787647127
# m.config[:config][:mapState][:zoom] = 16.0
# m.window[:map_legend_show] = false
# m.window[:map_legend_active] = false
# m.window[:visible_layers_show] = false
# m.window[:visible_layers_active] = false
# m.config[:config][:mapStyle][:styleType]="dark"

# win = KeplerGL.render(m)

# KeplerGL.export_image(win, "test2.png")

KeplerGL.add_grid_layer!(m, df, :latitude, :longitude,
     color=colorant"rgb(23, 184,190)", 
     color_field= :altitude,
     color_scale = "quantile", 
     color_range=parse.(Colorant, ["#5A1846","#900C3F","#C70039","#E3611C","#F1920E","#FFC300"]),
     opacity = 0.62,
     radius = 0.005,
     coverage = 0.95,
     height_field = :altitude,
     height_aggregation = "average",
     elevation_scale=0.3,
     enable_3d = true
     
     )

m.window[:toggle_3d_show] = true
m.window[:toggle_3d_active] = true
m.window[:map_legend_show] = false
m.window[:map_legend_active] = false
m.window[:visible_layers_show] = false
m.window[:visible_layers_active] = false
m.config[:config][:mapState][:latitude] = 29.642973900323852
m.config[:config][:mapState][:longitude]= -82.34761399099848
m.config[:config][:mapState][:zoom] = 15.941926775299756
m.config[:config][:mapState][:pitch] = 52.92875243297208
m.config[:config][:mapState][:bearing] = 69.28753840245776
m.window[:map_legend_show] = false
m.window[:map_legend_active] = false
m.window[:visible_layers_show] = false
m.window[:visible_layers_active] = false
m.config[:config][:mapStyle][:styleType]="dark"

win = KeplerGL.render(m)

KeplerGL.export_image(win, "data_3d_2.png")

# KeplerGL.add_hexagon_layer!(m, df, :latitude, :longitude,
#      height_field = :altitude, enable_3d=true,
#      height_range=[1, 13],
#      height_scale="linear",
#      opacity = 0.51, 
#      color_aggregation="average", 
#      color=colorant"rgb(23, 184,190)", color_field= :altitude,
#      color_range=parse.(Colorant, ["#00939C","#5DBABF","#BAE1E2","#F8C0AA","#DD7755","#C22E00"]),
#      radius=.003,
#      resolution=20
#      )

# m.config[:config][:mapState][:latitude] = 29.64281657981525
# m.config[:config][:mapState][:longitude]= -82.34662554441844
# m.config[:config][:mapState][:zoom] = 16.31611563725161
# m.config[:config][:mapState][:pitch] = 56.0219971625612
# m.config[:config][:mapState][:bearing] = -57.45833333333333
# m.window[:map_legend_show] = false
# m.window[:map_legend_active] = false
# m.window[:visible_layers_show] = false
# m.window[:visible_layers_active] = false
# m.config[:config][:mapStyle][:styleType]="dark"

# win = KeplerGL.render(m)

# KeplerGL.export_image(win, "test3d.png")

