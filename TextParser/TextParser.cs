using System.Collections.Concurrent;


namespace TextParser;

public static class TextParser
{
    private static readonly char[] PunctuationMarks =
        {',', '.', '!', '?', ':', '-', '—', '–', '«', '»', '“', '”', '/', '\\', '…', '[', ']', '{', '}', '(', ')', '>', '<',};

    private static IDictionary<string, int> GetWordFrequency(string text)
    {
        var stringFrequency = new Dictionary<string, int>();
        var lines = text.Split(PunctuationMarks, StringSplitOptions.RemoveEmptyEntries);

        foreach (var line in lines)
        {
            CountWordsInLine(line, stringFrequency);
        }

        return stringFrequency;
    }


    public static IDictionary<string, int> GetWordFrequencyWithTasks(string text)
    {
        var stringFrequency = new ConcurrentDictionary<string, int>();
        var tasks = new List<Task>();
        var lines = text.Split(PunctuationMarks, StringSplitOptions.RemoveEmptyEntries);

        foreach (var line in lines)
        {
            tasks.Add(Task.Run(() => CountWordsInLine(line, stringFrequency)));
        }

        Task.WaitAll(tasks.ToArray());

        return stringFrequency;
    }

    public static IDictionary<string, int> GetWordFrequencyParallel(string text)
    {
        var stringFrequency = new ConcurrentDictionary<string, int>();
        var lines = text.Split(PunctuationMarks, StringSplitOptions.RemoveEmptyEntries);

        Parallel.ForEach(lines, line =>
        {
            CountWordsInLine(line, stringFrequency);
        });

        return stringFrequency;
    }

    public static IDictionary<string, int> GetWordFrequencyThread(string text)
    {
        var stringFrequency = new ConcurrentDictionary<string, int>();
        var lines = text.Split(PunctuationMarks, StringSplitOptions.RemoveEmptyEntries);

        var threads = new List<Thread>();

        foreach (var line in lines)
        {
            var thread = new Thread(() => CountWordsInLine(line, stringFrequency));
            thread.Start();
            threads.Add(thread);
        }

        foreach (var thread in threads)
        {
            thread.Join();
        }

        return stringFrequency;
    }

    public static IDictionary<string, int> GetWordFrequencyThreadPool(string text)
    {
        var stringFrequency = new ConcurrentDictionary<string, int>();
        var lines = text.Split(PunctuationMarks, StringSplitOptions.RemoveEmptyEntries);

        var countdownEvent = new CountdownEvent(lines.Length);

        foreach (var line in lines)
        {
            ThreadPool.QueueUserWorkItem(_ =>
            {
                CountWordsInLine(line, stringFrequency);
                countdownEvent.Signal();
            });
        }

        countdownEvent.Wait();

        return stringFrequency;
    }

    public static Dictionary<string, int> SortWordFrequency(IDictionary<string, int> dictionary)
    {
        return dictionary.OrderByDescending(x => x.Value)
                         .ToDictionary(x => x.Key, x => x.Value);
    }

    private static void CountWordsInLine(string line, IDictionary<string, int> stringFrequency)
    {
        foreach (var word in line.Split())
        {
            var normalizedWord = NormalizeWord(word);

            if (!IsWord(normalizedWord))
            {
                continue;
            }

            if (stringFrequency.ContainsKey(normalizedWord))
            {
                stringFrequency[normalizedWord] += 1;
            }
            else
            {
                stringFrequency[normalizedWord] = 1;
            }
        }
    }

    private static void CountWordsInLine(string line, ConcurrentDictionary<string, int> stringFrequency)
    {
        foreach (var word in line.Split())
        {
            var normalizedWord = NormalizeWord(word);

            if (!IsWord(normalizedWord))
            {
                continue;
            }

            stringFrequency.AddOrUpdate(normalizedWord, 1, (s, i) => i += 1);
        }
    }

    private static string NormalizeWord(string word)
    {
        return word.ToLower().Trim(PunctuationMarks);
    }

    private static bool IsWord(string word)
    {
        if (string.IsNullOrWhiteSpace(word))
        {
            return false;
        }

        if (double.TryParse(word, out _))
        {
            return false;
        }

        return true;
    }
}
