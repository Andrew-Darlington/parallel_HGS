# An algorithm for HGS on parallel extensions 

[![DOI](https://zenodo.org/badge/744112400.svg)](https://zenodo.org/doi/10.5281/zenodo.10519675)

For a given positive integer n, the command "parallel_HGS_type(n);" outputs a list of records corresponding to a transitive subgroup G<Hol(N) possessing the parallel-noHGS property.
For example, the first entry in "parallel_HGS_type(8);" is:

rec<recformat<trans_gp, isom, type, parallel_data> |
        trans_gp := Permutation group acting on a set of cardinality 8
        Order = 32 = 2^5
            (1, 5, 4, 8)(2, 6, 3, 7)
            (1, 5, 2, 6)(3, 8, 4, 7)
            (1, 3)(2, 4)(5, 7)(6, 8)
            (1, 2)(3, 4)(5, 6)(7, 8)
            (5, 6)(7, 8),
        isom := C2^2.D4,
        type := C2*C4,
        parallel_data := [
            rec<recformat<index_n_subgp, core> |
                index_n_subgp := Permutation group acting on a set of
                    cardinality 8
                Order = 4 = 2^2
                    (5, 6)(7, 8)
                    (1, 3)(2, 4)(5, 8)(6, 7),
                core := Permutation group acting on a set of cardinality 8
                Order = 1>
        ]>
		
This is interpreted as follows:
	"trans_gp" gives G as a permutation group,
	"isom" gives the abstract isomorphism type of G,
	"type" gives the abstract isomorphism type of N,
	"parallel_data" is a list containing details of the index n subgroups H of G which correspond to an extension admitting no HGS. The fields of these records are:
		'index_n_subgp', which gives H as a permutation group, and
		'core', which gives Core_G(H).