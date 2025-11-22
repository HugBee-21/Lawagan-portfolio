<label class="custom-radio">
    <input type="radio" name="<?= $name ?>" value="<?= strtolower($value) ?>"/>
    <span class="radiomark"></span>
    <?= is_null($txt) ? $value : $txt?>
</label>