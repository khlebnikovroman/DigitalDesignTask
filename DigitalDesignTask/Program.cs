using System.Diagnostics;
using System.Reflection;


public static class Program
{
    public static void Main()
    {
        var text = File.ReadAllText("voina-i-mir.txt");

        var privateMethod = typeof(TextParser.TextParser).GetMethod("GetWordFrequency", BindingFlags.NonPublic | BindingFlags.Static);

        var methods = new Dictionary<string, Func<string, IDictionary<string, int>>>
        {
            {"Normal", s => (Dictionary<string, int>) privateMethod.Invoke(null, new object?[] {s,})},
            {"Tasks", TextParser.TextParser.GetWordFrequencyWithTasks},
            {"Parallel", TextParser.TextParser.GetWordFrequencyParallel},
            {"Thread", TextParser.TextParser.GetWordFrequencyThread},
            {"ThreadPool", TextParser.TextParser.GetWordFrequencyThreadPool},
        };

        var sw = new Stopwatch();

        foreach (var method in methods)
        {
            sw.Restart();
            var frequency = method.Value(text);
            sw.Stop();
            frequency = TextParser.TextParser.SortWordFrequency(frequency);
            PrintFrequencyToFile(frequency, $"out{method.Key}.txt");
            Console.WriteLine($"{method.Key}: {sw.ElapsedMilliseconds} ms.");
        }
    }

    private static void PrintFrequencyToFile(IDictionary<string, int> frequency, string path)
    {
        using var writer = new StreamWriter(path);

        foreach (var i in frequency)
        {
            writer.WriteLine($"{i.Key} {i.Value}");
        }
    }
}
