
using System.Reflection;


public static class Program
{
    public static void Main()
    {
        var method = typeof(TextParser.TextParser).GetMethod("GetStringsFrequency", BindingFlags.NonPublic | BindingFlags.Static);
        var freq =(Dictionary<string, int>) method.Invoke(null, new object?[]{"voina-i-mir.txt"});
        freq = freq.OrderByDescending(x=>x.Value)
                   .ToDictionary(x=>x.Key,x=>x.Value);
        PrintFrequencyToFile(freq, "out.txt");
    }
        
    private static void PrintFrequencyToFile(Dictionary<string, int> frequency, string path)
    {
        using var writer = new StreamWriter(path);

        foreach (var i in frequency)
        {
            writer.WriteLine($"{i.Key} {i.Value}");
        }
    }
}


