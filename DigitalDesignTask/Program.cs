﻿using System.Diagnostics;
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
            {"ParallelWebApi", text =>
            {
                try
                {
                    var client = new WebApiClient.WordFrequencyClient("https://localhost:7215/", new HttpClient());

                    return client.WordFrequencyAsync(text).Result;
                }
                catch (AggregateException e)
                {
                    Console.WriteLine("Server error, make sure the server is running");

                    return null;
                }
                
            }
                
            }
        };

        var sw = new Stopwatch();

        foreach (var method in methods)
        {
            sw.Restart();
            var frequency = method.Value(text);
            

            if (frequency is null)
            {
                Console.WriteLine($"{method.Key} returned null");
                continue;
            }

            if (method.Key!="ParallelWebApi")
            {
                frequency = TextParser.TextParser.SortWordFrequency(frequency);
            }
            sw.Stop();
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
