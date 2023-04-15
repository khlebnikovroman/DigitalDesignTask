﻿namespace DigitalDesignTask;

public static class TextParser
{
    public static Dictionary<string, int> GetStringsFrequency(string path)
    {
        var stringFrequency = new Dictionary<string, int>();
        using var fileStream = new StreamReader(path);

        var line=fileStream.ReadLine();

        while (line is not null)
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
            line=fileStream.ReadLine();
        }

        return stringFrequency;
    }

    private static char[] PunctuationMarks = {',','.','!','?',':','-','—','–','«','»','“','”','/','\\','…','[',']','{','}','(',')','>','<'};
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
    

    public static void PrintFrequencyToFile(Dictionary<string, int> frequency, string path)
    {
        using var writer = new StreamWriter(path);

        foreach (var i in frequency)
        {
            writer.WriteLine($"{i.Key} {i.Value}");
        }
    }
}
