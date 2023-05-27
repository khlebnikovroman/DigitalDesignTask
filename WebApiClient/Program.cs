var text = File.ReadAllText("voina-i-mir.txt");
var client = new WebApiClient.WordFrequencyClient("https://localhost:7215/", new HttpClient());
var freq = await client.WordFrequencyAsync(text);
PrintFrequencyToFile(freq, "out.txt");

void PrintFrequencyToFile(IDictionary<string, int> frequency, string path)
{
    using var writer = new StreamWriter(path);

    foreach (var i in frequency)
    {
        writer.WriteLine($"{i.Key} {i.Value}");
    }
}