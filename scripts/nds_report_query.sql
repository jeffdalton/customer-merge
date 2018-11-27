select n.nds_number, n.partyid
from non_deal_support_customers n
inner join merge_list m on n.partyid = m.mergee