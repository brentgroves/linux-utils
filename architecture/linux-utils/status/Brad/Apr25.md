status:
Good morning dear ones,
I hope you guys are doing well today and look forward to talking with you today.
If you are available, I would like your feedback on this report Brad has been working on and I have been helping with.
Sincerely yours,
Brent 260-564-4868

Answer business questions using our databases. 
Name: Material Needed report
Why: So we know what raw to buy.
Why isn't this a standard report: Maybe because it depends how the organization assigns part numbers to raw, wip, and finished goods.
How: How does Plex determine material requirements?
Set: 1 line for each part with a raw, wip, or finished part.
raw part number, quantity, wip part numbers with quantity list, and finished goods part numbers with quantities list.
Check it:
1. Find existing Plex inventory report or web service.
2. Compare a few part quantities from our report to Plex on a Saturday or when CNC isn't running.
Similar Plex Reports:

Enhancement:
Add material requirement for each part.

brad_part_v_bom
Linked up part_v_bom to some tables.
Next try get finish goods.

I am trying to go from finish good back to raw material in machine shops using their part no.

So in the part_v_bom table there is a "component_part_key" This is the part_key for the component of the part. So if a finish good has a WIP process part no then the component key for the finish good part is the WIP part no. Similarly the  component part key for the WIP part no would be the raw goods part key. I am trying to figure out how to get these all on one row, or at least the current quantities of each on the same row.

select * from part_v_bom
part_v_bom
part_key
part_operation_key
component_part_key


RP 
component_key 
No records

Answer_BOM