include("../../datatools.jl")
using KeplerGL, Colors, ColorBrewer

all_dfs = get_all_dataframes();

df = stack_all_streets(all_dfs);

token = KEPLER_TOKEN;
# m = KeplerGL.KeplerGLMap(token, center_map=true)

# KeplerGL.add_point_layer!(m, df, :latitude, :longitude,
#      color=colorant"rgb(23, 184,190)", color_field= :altitude,
#      color_scale = "quantize", 
#      color_range=parse.(Colorant, ["#00939C","#5DBABF","#BAE1E2","#F8C0AA","#DD7755","#C22E00"]),
#      radius_field = :altitude, radius_scale = "sqrt", radius_range = [2, 8], radius_fixed = false,
#      filled = true, opacity = 0.1, outline = false);

# m.config[:config][:mapState][:latitude] = 29.643836
# m.config[:config][:mapState][:longitude]= -82.346674
# m.config[:config][:mapState][:zoom] = 14
# m.window[:map_legend_show] = false
# m.window[:map_legend_active] = false
# m.window[:visible_layers_show] = false
# m.window[:visible_layers_active] = false
# m.config[:config][:mapStyle][:styleType]="dark"

# win = KeplerGL.render(m)

# KeplerGL.export_image(win, "test2.png")


m = KeplerGL.KeplerGLMap(token, center_map=false)
m.window[:toggle_3d_show] = true
m.window[:toggle_3d_active] = true
m.window[:map_legend_show] = false
m.window[:map_legend_active] = false
m.window[:visible_layers_show] = false
m.window[:visible_layers_active] = false

KeplerGL.add_hexagon_layer!(m, df, :latitude, :longitude,
     height_field = :altitude, enable_3d=true,
     height_range=[1, 15],
     height_scale="linear",
     opacity = 0.51, 
     color_aggregation="average", 
     color=colorant"rgb(23, 184,190)", color_field= :altitude,
     color_range=parse.(Colorant, ["#00939C","#5DBABF","#BAE1E2","#F8C0AA","#DD7755","#C22E00"]),
     radius=.005;
     )

m.config[:config][:mapState][:latitude] = 29.64281657981525
m.config[:config][:mapState][:longitude]= -82.34662554441844
m.config[:config][:mapState][:zoom] = 16.31611563725161
m.config[:config][:mapState][:pitch] = 48.67799192421264
m.config[:config][:mapState][:bearing] = -56.83333333333333
m.window[:map_legend_show] = false
m.window[:map_legend_active] = false
m.window[:visible_layers_show] = false
m.window[:visible_layers_active] = false
m.config[:config][:mapStyle][:styleType]="dark"

win = KeplerGL.render(m)

KeplerGL.export_image(win, "test3d.png")