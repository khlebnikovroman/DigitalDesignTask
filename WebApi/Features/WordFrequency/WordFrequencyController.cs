using Microsoft.AspNetCore.Mvc;


namespace WebApi.Controllers;

[ApiController]
[Route("[controller]")]
public class WordFrequencyController : ControllerBase
{
    
    [HttpPost]
    public async Task<ActionResult<Dictionary<string,int>>> Get([FromBody] string text)
    {
        var freq = TextParser.TextParser.GetWordFrequencyParallel(text);
        freq = TextParser.TextParser.SortWordFrequency(freq);

        return Ok(freq);
    }
}
