genid()

{
        (
        mkdir -p /tmp

        #initialize counter file if it does not exist
        if [ -f /tmp/genid.counter ]; then
                echo 0 > /tmp/genid.counter
        fi

        flock -x 200 

        #reads current counter value, incriments it, and prints output
        counter=$(cat /tmp/genid.counter)
        counter=$((counter + 1))
        echo "$counter" > /tmp/genid.counter
        printf "%05d\n" $counter
        ) 200>/tmp/genid.lock

}

num_process=10
num_idper_process=100


#Generates IDs
for ((i =0; i < num_process; i++)); do
        for ((j = 0; j < num_idper_process; j++)); do
                genid
        done

done | sort -n -u | awk 'BEGIN{prev=0} {if ($1 != prev+1) {print "Error: gap or duplicate detected"; exit 1} prev=$1}' && echo "all IDs Generated successfully"
