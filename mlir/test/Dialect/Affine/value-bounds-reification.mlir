// RUN: mlir-opt %s -test-affine-reify-value-bounds -allow-unregistered-dialect 

func.func @hoist_vector_transfer_pairs_disjoint_dynamic(
    %buffer: memref<?x?xf32>, %lb : index, %ub : index, %step: index, %i0 : index, %i1 : index) {
  %cst = arith.constant 0.0 : f32
  %i2 = affine.apply affine_map<(d0) -> ((d0 floordiv 32) * 16)>(%i1)
  %i3 = affine.apply affine_map<(d0) -> ((d0 floordiv 32) * 16 + 8)>(%i1)
  %s = affine.apply affine_map<()[s0, s1] -> (s0 - s1)>()[%i2, %i3]
  %const = "test.reify_constant_bound"(%s) {type = "EQ"} : (index) -> (index)
  return
}
