using System.Reflection;

using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;


public class Program
{
    public static void Main()
    {
        BenchmarkRunner.Run<StringFrequencyBenchMark>();
    }
}


public class StringFrequencyBenchMark
{
    private readonly string text = File.ReadAllText("voina-i-mir.txt");

    [Benchmark(Description = "Normal")]
    public void Normal()
    {
        var privateMethod = typeof(TextParser.TextParser).GetMethod("GetWordFrequency", BindingFlags.NonPublic | BindingFlags.Static);
        var freq = (Dictionary<string, int>) privateMethod.Invoke(null, new object?[] {text,});
    }
    [Benchmark(Description = "Tasks")]
    public void Tasks()
    {
        var freq = TextParser.TextParser.GetWordFrequencyWithTasks(text);
    }

    [Benchmark(Description = "Parallel")]
    public void Parallel()
    {
        var freq = TextParser.TextParser.GetWordFrequencyParallel(text);
    }

    [Benchmark(Description = "Threads")]
    public void Threads()
    {
        var freq = TextParser.TextParser.GetWordFrequencyThread(text);
    }

    [Benchmark(Description = "ThreadPool")]
    public void ThreadPool()
    {
        var freq = TextParser.TextParser.GetWordFrequencyThreadPool(text);
    }
}
