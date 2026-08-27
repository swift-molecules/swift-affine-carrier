public import Affine
public import Carrier

extension Int {

    @inlinable
    public init(bitPattern vector: Affine.Discrete.Vector) {
        self = vector.rawValue
    }

    @inlinable
    public init(bitPattern carrier: some Carrier.`Protocol`<Affine.Discrete.Vector>) {
        self.init(bitPattern: carrier.underlying)
    }
}
