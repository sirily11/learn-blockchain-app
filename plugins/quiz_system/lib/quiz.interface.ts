interface Quiz{
    name: string;
    description: string;
    selections: Selection[];
    answer: Answer[]
}

interface Selection{
    description: string;
}

interface Answer{
    index: number;
    description: string;
}