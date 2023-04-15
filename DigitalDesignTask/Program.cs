using DigitalDesignTask;

var freq = TextParser.GetStringsFrequency("voina-i-mir.txt");
freq = freq.OrderByDescending(x=>x.Value)
           .ToDictionary(x=>x.Key,x=>x.Value);
TextParser.PrintFrequencyToFile(freq, "out.txt");
