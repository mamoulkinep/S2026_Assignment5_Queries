#1
SELECT quantityOnHand FROM item WHERE itemDescription = 'bottle of antibiotics';

#2
SELECT volunteerName FROM volunteer WHERE volunteerTelephone NOT LIKE '2%'AND volunteerName NOT LIKE '%Jones';

#3
SELECT volunteerName FROM volunteer
JOIN assignment ON assignment.volunteerId = volunteer.volunteerId
JOIN task ON task.taskCode = assignment.taskCode
JOIN task_type ON task_type.taskTypeId = task.taskTypeId
WHERE task.taskTypeId = 3;

#4
SELECT taskDescription
FROM task
LEFT JOIN assignment ON assignment.taskCode = task.taskCode
WHERE assignment.taskCode IS NULL;

#5
SELECT DISTINCT packageTypeName FROM package_type
JOIN package ON package.packageTypeId = package_type.packageTypeId
JOIN package_contents ON package_contents.packageId = package.packageId
JOIN item ON item.itemId = package_contents.itemId
WHERE itemDescription LIKE '%bottle%';

#6
SELECT itemDescription FROM item
LEFT JOIN package_contents ON package_contents.itemId = item.itemId
WHERE package_contents.itemId IS NULL;

#7
SELECT DISTINCT taskDescription FROM task
JOIN assignment ON assignment.taskCode = task.taskCode
JOIN volunteer ON volunteer.volunteerId = assignment.volunteerId
WHERE volunteerAddress LIKE '%NJ';

#8
SELECT volunteerName FROM volunteer
JOIN assignment ON assignment.volunteerId = volunteer.volunteerId
WHERE assignment.startDateTime < '2021-07-01' AND assignment.startDateTime >= '2021-01-01';

#9
SELECT DISTINCT volunteerName FROM volunteer
JOIN assignment ON assignment.volunteerId = volunteer.volunteerId
JOIN task ON task.taskCode = assignment.taskCode
JOIN package ON package.taskCode = task.taskCode
JOIN package_contents ON package_contents.packageId = package.packageId
JOIN item ON item.itemId = package_contents.itemId
WHERE item.itemDescription LIKE '%spam%';

#10
SELECT itemDescription FROM item
JOIN package_contents ON package_contents.itemId = item.itemId
WHERE item.itemValue * package_contents.itemQuantity = 100;

#11
SELECT task_status.taskStatusName,
COUNT(DISTINCT volunteer.volunteerId) AS volunteerCount
FROM task_status
LEFT JOIN task ON task.taskStatusId = task_status.taskStatusId
LEFT JOIN assignment ON assignment.taskCode = task.taskCode
LEFT JOIN volunteer ON volunteer.volunteerId = assignment.volunteerId
GROUP BY task_status.taskStatusName
ORDER BY volunteerCount DESC, task_status.taskStatusName;

#12
SELECT package.taskCode,
SUM(package.packageWeight) AS totalWeight
FROM package
GROUP BY package.taskCode
ORDER BY totalWeight DESC
LIMIT 1;

#13
SELECT COUNT(*)
FROM task
JOIN task_type ON task.taskTypeId = task_type.taskTypeId
WHERE task_type.taskTypeName <> 'packing';

#14
SELECT item.itemDescription
FROM item
JOIN package_contents ON package_contents.itemId = item.itemId
JOIN package ON package.packageId = package_contents.packageId
JOIN task ON task.taskCode = package.taskCode
JOIN assignment ON assignment.taskCode = task.taskCode
JOIN volunteer ON volunteer.volunteerId = assignment.volunteerId
GROUP BY item.itemId, item.itemDescription
HAVING COUNT(DISTINCT volunteer.volunteerId) < 3;

#15
SELECT package.packageId,
SUM(item.itemValue * package_contents.itemQuantity) AS totalValue
FROM package
JOIN package_contents ON package_contents.packageId = package.packageId
JOIN item ON item.itemId = package_contents.itemId
GROUP BY package.packageId
HAVING SUM(item.itemValue * package_contents.itemQuantity) > 100
ORDER BY totalValue ASC;

