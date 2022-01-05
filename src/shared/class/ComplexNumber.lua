local ComplexNumber = {}

type ComplexNumber = {
    Real: number;
    Imaginary: number;
}

function ComplexNumber:Multiply (other: ComplexNumber)
    return {
        Real = self.Real * other.Real - self.Imaginary * other.Imaginary;
        Imaginary = self.Real * other.Imaginary + self.Imaginary * other.Real;
    }
end

function ComplexNumber:Square ()
    return self:Multiply(self)
end

return ComplexNumber