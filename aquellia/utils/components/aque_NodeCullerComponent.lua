--- No idea what NodeCuller is
---
--- flow_field_size: float
--- manual: bool
--- multiplayer: float
--- nav_mesh_cull_type: int
--- cost_Type: uint
--- current_node_index: uint
--- nodes: Vector_int
---
---
---

--- Logs the NodeCullerComponent details of a blueprint
function LogNodeCullerComponent(blueprint)
    local component = blueprint:GetComponent("NodeCullerComponent")
end