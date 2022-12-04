add_subdirectory(dag)

pf_define_submodule(pitchfork-core SHARED
  UNITS
    Point
  OBJECT_LIBRARIES
    pitchfork-core-dag
)
