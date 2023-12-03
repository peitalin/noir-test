
use dep::std;

struct Foo {
    bar: Field,
    baz: Field
}

fn addFoo(foos: [Foo; 3]) -> Field {
    foos[2].bar + foos[2].baz
}

fn checkMerkle(message: [Field; 62], index: Field, hashpath: [Field; 40], root: Field) {
    let leaf = std::hash::hash_to_field(message);
    let merkle_root = std::merkle::compute_merkle_root(leaf, index, hashpath);
    // can also use std::merkle::pedersen_hash instead if only collision resistance is needed
    assert(merkle_root == root);
}

fn main(foos: [Foo; 3]) {
    addFoo(foos);
}


#[test]
fn test_main() {

    let foo1 = Foo {
        bar: 0,
        baz: 0
    };

    let foo2 = Foo {
        bar: 0,
        baz: 0
    };

    let foo3 = Foo {
        bar: 1,
        baz: 2
    };

    let ans = addFoo([foo1, foo2, foo3]);
    assert(ans == 3);

    // Uncomment to make test fail
    // main(1, 1);
}
